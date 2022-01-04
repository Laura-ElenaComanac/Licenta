package com.license.ProjectSocialNetwork.controller;

import com.license.ProjectSocialNetwork.controller.dto.UserDTO;
import com.license.ProjectSocialNetwork.converter.UserConverter;
import com.license.ProjectSocialNetwork.model.User;
import com.license.ProjectSocialNetwork.services.UserService;
import com.license.ProjectSocialNetwork.services.UserServiceImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;

@Controller
//@RequestMapping( value = "/" )
public class UsersController {

    private final static Logger log = LogManager.getLogger(UserServiceImpl.class);

    @Autowired
    private UserService userService;

    @Autowired
    private UserConverter userConverter;
//    private SimpMessagingTemplate simpMessagingTemplate;
//
//    @MessageMapping("/destination")
//    @SendTo("/topic/destination")
//    public List<User> sendMessage(){
//        log.info("sendMessage(): Called...");
////        List<User> users = userService.findAll();
////        simpMessagingTemplate.convertAndSend("/destination/" + to, users);
//
//        List<User> users = userService.findAll();
//        return users;
//    }

    @GetMapping("users")
    public @ResponseBody
    List<UserDTO> getUsers() {
        log.info("getUsers(): Called...");
        List<User> users = new LinkedList<>();
        try {
            users = userService.findAllUsers();
            log.info(users.toString() + " returned");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return userConverter.convertModelsToDTOsList(users);
    }

    @PostMapping("user/add")
    public @ResponseBody
    UserDTO addUser(@RequestParam(value = "username") String username,
                    @RequestParam(value = "password") String password,
                    @RequestParam(value = "firstName") String firstName,
                    @RequestParam(value = "lastName") String lastName,
                    @RequestParam(value = "gender") String gender){
        log.info("addUser(): Called...");

        User user = User.builder()
                .firstName(firstName)
                .lastName(lastName)
                .username(username)
                .password(password)
                .gender(gender)
                .build();

        userService.saveUser(user);

        System.out.println("User: " + user);

        return userConverter.convertModelToDto(user);
    }


    @PutMapping("user/update")
    public @ResponseBody
    UserDTO updateUser (@RequestParam(value = "id") Long id,
                                          @RequestParam(value = "username") String username,
                                          @RequestParam(value = "password") String password,
                                          @RequestParam(value = "firstName") String firstName,
                                          @RequestParam(value = "lastName") String lastName,
                                          @RequestParam(value = "gender") String gender) {
        log.info("updateUser(): Called... with: " );

        User user = User.builder()
                .firstName(firstName)
                .lastName(lastName)
                .username(username)
                .password(password)
                .gender(gender)
                .build();
        user.setId(id);

        userService.updateUser(user);

        log.info("User: " + user);

        return userConverter.convertModelToDto(user);
    }

    @DeleteMapping("user/delete")
    public @ResponseBody
    Long deleteUser(@RequestParam(value = "id") Long id) {
        log.info("deleteUser(): Called...");

        userService.deleteUser(id);

        System.out.println("Userid: " + id);

        return id;
    }
}

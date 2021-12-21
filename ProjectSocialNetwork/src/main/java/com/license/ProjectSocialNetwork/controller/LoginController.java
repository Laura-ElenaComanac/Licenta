package com.license.ProjectSocialNetwork.controller;

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
@RequestMapping( value = "/" )
public class LoginController {

    private final static Logger log = LogManager.getLogger(UserServiceImpl.class);

    @Autowired
    private UserService userService;

    @GetMapping("users")
    public @ResponseBody
    //@RequestMapping(value = "/users", method= RequestMethod.GET)
    List<User> getUsers() {
        log.info("getUsers(): Called...");
        List<User> users = new LinkedList<>();
        try {
            users = userService.findAll();
            log.info(users.toString() + " returned");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return users;
    }

}

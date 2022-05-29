package com.license.ProjectSocialNetwork.controller;

import com.license.ProjectSocialNetwork.controller.dto.PostDTO;
import com.license.ProjectSocialNetwork.controller.dto.PostUserDTO;
import com.license.ProjectSocialNetwork.controller.dto.UserDTO;
import com.license.ProjectSocialNetwork.converter.PostConverter;
import com.license.ProjectSocialNetwork.converter.PostUserConverter;
import com.license.ProjectSocialNetwork.converter.UserConverter;
import com.license.ProjectSocialNetwork.model.Post;
import com.license.ProjectSocialNetwork.model.User;
import com.license.ProjectSocialNetwork.services.PostService;
import com.license.ProjectSocialNetwork.services.UserService;
import com.license.ProjectSocialNetwork.services.UserServiceImpl;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class PostsController {

    private final static Logger log = LogManager.getLogger(UserServiceImpl.class);

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private PostConverter postConverter;

    @Autowired
    private PostUserConverter postUserConverter;

    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @GetMapping("posts")
    public @ResponseBody
    List<PostUserDTO> getPosts() {
        List<PostUserDTO> posts = new LinkedList<>();
        try {
            posts = postUserConverter.convertModelsToDTOsList(postService.findAllPostsWithTheirUsers());
            log.info(posts.toString() + " returned");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return posts;
    }

    @GetMapping("post/filter")
    public @ResponseBody
    List<PostDTO> getUserPosts(@RequestParam(value = "userid") Long userid) {
        List<Post> posts = new LinkedList<>();
        try {
            posts = postService.findUserPosts(userid);
            log.info(posts.toString() + " returned");
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return postConverter.convertModelsToDTOsList(posts);
    }

    @PostMapping("post/add")
    public @ResponseBody
    PostUserDTO addPost(@RequestParam(value = "date") String date,
                    @RequestParam(value = "description") String description,
                    @RequestParam(value = "title") String title,
                    @RequestParam(value = "userid") String userid){
        log.info("addUser(): Called...");

        Post post = Post.builder()
                .date(date)
                .description(description)
                .title(title)
                .build();
        postService.savePost(post, Long.valueOf(userid));

        PostUserDTO postDTO = postUserConverter.convertModelToDto(post);
        simpMessagingTemplate.convertAndSend("/topic2/add", postDTO);

        log.info("added: " + postDTO);

        return postDTO;
    }

    @DeleteMapping("post/delete")
    public @ResponseBody
    Long deletePost(@RequestParam(value = "id") Long id) {
        log.info("deleteUser(): Called...");

        postService.deletePost(id);

        System.out.println("Postid: " + id);

        simpMessagingTemplate.convertAndSend("/topic2/delete", id);

        log.info("deleted: " + id);

        return id;
    }
}

package com.license.ProjectSocialNetwork.services;

import com.license.ProjectSocialNetwork.model.Post;
import com.license.ProjectSocialNetwork.model.User;
import com.license.ProjectSocialNetwork.repository.PostRepository;
import com.license.ProjectSocialNetwork.repository.UserRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.LinkedList;
import java.util.List;

@Service
public class PostServiceImpl implements PostService{
    @PersistenceContext
    private EntityManager em;

    private final static Logger log = LogManager.getLogger(UserServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    @Override
    public List<Post> findAllPosts() {
        log.traceEntry("Returning all posts...");
        return postRepository.findAll();
    }

    @Override
    public List<Post> findAllPostsWithTheirUsers() {
        log.traceEntry("Returning all posts with their users...");
        return postRepository.findPostsWithUser();
    }

    @Override
    public void savePost(Post post, Long userId) {
        log.traceEntry("Saving post...");
        try {
            post.setUser(userRepository.findById(userId).get());
            postRepository.save(post);
        }
        catch (NullPointerException exception) {
            log.traceEntry(exception.toString());
        }
    }

    @Override
    public void deletePost(Long id) {
        log.traceEntry("Deleting post...");
        try {
            postRepository.deleteById(id);
        }
        catch (NullPointerException exception) {
            log.traceEntry(exception.toString());
        }
    }

    @Override
    public List<Post> findUserPosts(Long userId) {
        log.traceEntry("Returning user posts...");
        User user = userRepository.findUserWithPosts(userId);
        if(user == null){
            log.traceEntry("User does not exist with id " + userId);
            return new LinkedList<>();
        }
        log.traceEntry("Returning " + user.getPosts());
        return user.getPosts();
    }
}

package com.license.ProjectSocialNetwork.services;

import com.license.ProjectSocialNetwork.model.Post;

import java.util.List;

public interface PostService {
    List<Post> findAllPosts();
    void savePost(Post post, Long userId);
    void deletePost(Long id);
    List<Post> findUserPosts(Long userId);
    public List<Post> findAllPostsWithTheirUsers();
}

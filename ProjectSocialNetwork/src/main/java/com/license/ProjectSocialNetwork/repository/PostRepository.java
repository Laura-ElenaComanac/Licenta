package com.license.ProjectSocialNetwork.repository;

import com.license.ProjectSocialNetwork.model.Post;
import com.license.ProjectSocialNetwork.model.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PostRepository extends SocialRepository<Post, Long>{
    @Query("select distinct p from Post p")
    @EntityGraph(value = "postWithUser", type = EntityGraph.EntityGraphType.LOAD)
    List<Post> findPostsWithUser();
}

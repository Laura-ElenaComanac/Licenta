package com.license.ProjectSocialNetwork.repository;


import com.license.ProjectSocialNetwork.model.User;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;


@Transactional
@Repository
public interface UserRepository extends SocialRepository<User, Long> {
    @Query("select distinct u from User u where u.id = ?1")
    @EntityGraph(value = "userWithPosts", type = EntityGraph.EntityGraphType.LOAD)
    User findUserWithPosts(Long id);

    @Query("select distinct u from User u where u.username = ?1 and u.password = ?2")
   // @EntityGraph(value = "user", type = EntityGraph.EntityGraphType.LOAD)
    User findUserByUsernameAndPassword(String username, String password);
}

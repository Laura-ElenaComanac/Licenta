package com.license.ProjectSocialNetwork.repository;


import com.license.ProjectSocialNetwork.model.User;
import org.springframework.stereotype.Repository;


@Repository
public interface UserRepository extends SocialRepository<User, Long> {
}

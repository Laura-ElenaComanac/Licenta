package com.license.ProjectSocialNetwork.repository;


import com.license.ProjectSocialNetwork.model.User;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;


@Transactional
@Repository
public interface UserRepository extends SocialRepository<User, Long> {
}

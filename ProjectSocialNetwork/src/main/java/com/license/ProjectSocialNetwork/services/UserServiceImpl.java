package com.license.ProjectSocialNetwork.services;

import com.license.ProjectSocialNetwork.model.User;
import com.license.ProjectSocialNetwork.repository.UserRepository;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{
    @PersistenceContext
    private EntityManager em;

    private final static Logger log = LogManager.getLogger(UserServiceImpl.class);

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<User> findAll() {
        log.traceEntry("Returning all users...");
        List<User> users;
        try {
            users = userRepository.findAll();
            log.trace("Returned all users");
        }
        catch (Exception ex){
            log.error(ex);
            System.out.println("Error Service "+ex);
            return null;
        }
        log.traceExit();
        return users;
    }
}

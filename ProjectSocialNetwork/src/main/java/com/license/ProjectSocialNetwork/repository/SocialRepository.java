package com.license.ProjectSocialNetwork.repository;

import com.license.ProjectSocialNetwork.model.BaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.io.Serializable;

public interface SocialRepository <T extends BaseEntity<ID>, ID extends Serializable> extends JpaRepository<T, ID> {
}
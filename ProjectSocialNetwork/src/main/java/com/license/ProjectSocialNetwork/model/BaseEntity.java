package com.license.ProjectSocialNetwork.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;

@MappedSuperclass
@Getter
@Setter
@NoArgsConstructor
public abstract class BaseEntity <ID extends Serializable> implements Serializable {

    @Id
    @GeneratedValue
    private ID id;
}

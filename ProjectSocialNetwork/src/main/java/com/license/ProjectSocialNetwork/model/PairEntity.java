package com.license.ProjectSocialNetwork.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
@Getter @Setter @NoArgsConstructor
public class PairEntity{
    @Id
    Tuple<Long,Long> pair;
}


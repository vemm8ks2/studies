package org.vemm8ks2.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

  private String filename;
  private String uploadPath;
  private String uuid;
  private boolean image;
}

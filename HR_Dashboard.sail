a!localVariables(
  /* Sample data for demonstration */
  local!activeJobRoles: 45,
  local!inactiveJobRoles: 12,
  local!tempVacancies: 23,
  local!permanentVacancies: 18,
  
  local!jobListings: {
    {
      jobName: "Senior Software Engineer",
      vacancies: 3,
      applicants: 47,
      status: "Open",
      urgent: false
    },
    {
      jobName: "Marketing Manager",
      vacancies: 1,
      applicants: 32,
      status: "Urgent",
      urgent: true
    },
    {
      jobName: "Data Analyst",
      vacancies: 2,
      applicants: 28,
      status: "Open",
      urgent: false
    },
    {
      jobName: "UX Designer",
      vacancies: 1,
      applicants: 19,
      status: "Open",
      urgent: false
    },
    {
      jobName: "HR Business Partner",
      vacancies: 1,
      applicants: 15,
      status: "Urgent",
      urgent: true
    },
    {
      jobName: "DevOps Engineer",
      vacancies: 2,
      applicants: 23,
      status: "Open",
      urgent: false
    }
  },
  
  {
    a!headerContentLayout(
      header: {
        a!richTextDisplayField(
          value: {
            a!richTextItem(
              text: "HR Dashboard",
              size: "LARGE_PLUS",
              style: "STRONG",
              color: "ACCENT"
            )
          },
          align: "CENTER"
        )
      },
      contents: {
        /* KPI Header Section */
        a!sectionLayout(
          label: "",
          contents: {
            a!columnsLayout(
              columns: {
                /* Active Job Roles KPI */
                a!columnLayout(
                  contents: {
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "briefcase",
                              size: "LARGE",
                              color: "POSITIVE"
                            ),
                            " ",
                            a!richTextItem(
                              text: local!activeJobRoles,
                              size: "LARGE_PLUS",
                              style: "STRONG",
                              color: "POSITIVE"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Active Job Roles",
                              size: "MEDIUM",
                              style: "EMPHASIS"
                            )
                          },
                          align: "CENTER"
                        )
                      },
                      style: "ACCENT",
                      decorativeBarPosition: "TOP",
                      decorativeBarColor: "POSITIVE",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false,
                      accessibilityText: "Active Job Roles: " & local!activeJobRoles
                    )
                  },
                  width: "NARROW_PLUS"
                ),
                
                /* Inactive Job Roles KPI */
                a!columnLayout(
                  contents: {
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "times-circle",
                              size: "LARGE",
                              color: "NEGATIVE"
                            ),
                            " ",
                            a!richTextItem(
                              text: local!inactiveJobRoles,
                              size: "LARGE_PLUS",
                              style: "STRONG",
                              color: "NEGATIVE"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Inactive Job Roles",
                              size: "MEDIUM",
                              style: "EMPHASIS"
                            )
                          },
                          align: "CENTER"
                        )
                      },
                      style: "ACCENT",
                      decorativeBarPosition: "TOP",
                      decorativeBarColor: "NEGATIVE",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false,
                      accessibilityText: "Inactive Job Roles: " & local!inactiveJobRoles
                    )
                  },
                  width: "NARROW_PLUS"
                ),
                
                /* Temporary Hire Vacancies KPI */
                a!columnLayout(
                  contents: {
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "clock",
                              size: "LARGE",
                              color: "SECONDARY"
                            ),
                            " ",
                            a!richTextItem(
                              text: local!tempVacancies,
                              size: "LARGE_PLUS",
                              style: "STRONG",
                              color: "SECONDARY"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Temporary Vacancies",
                              size: "MEDIUM",
                              style: "EMPHASIS"
                            )
                          },
                          align: "CENTER"
                        )
                      },
                      style: "ACCENT",
                      decorativeBarPosition: "TOP",
                      decorativeBarColor: "SECONDARY",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false,
                      accessibilityText: "Temporary Vacancies: " & local!tempVacancies
                    )
                  },
                  width: "NARROW_PLUS"
                ),
                
                /* Permanent Hire Vacancies KPI */
                a!columnLayout(
                  contents: {
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "user-check",
                              size: "LARGE",
                              color: "ACCENT"
                            ),
                            " ",
                            a!richTextItem(
                              text: local!permanentVacancies,
                              size: "LARGE_PLUS",
                              style: "STRONG",
                              color: "ACCENT"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Permanent Vacancies",
                              size: "MEDIUM",
                              style: "EMPHASIS"
                            )
                          },
                          align: "CENTER"
                        )
                      },
                      style: "ACCENT",
                      decorativeBarPosition: "TOP",
                      decorativeBarColor: "ACCENT",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false,
                      accessibilityText: "Permanent Vacancies: " & local!permanentVacancies
                    )
                  },
                  width: "NARROW_PLUS"
                )
              },
              spacing: "STANDARD",
              stackWhen: {
                "PHONE",
                "TABLET_PORTRAIT"
              }
            )
          },
          marginBelow: "MORE"
        ),
        
        /* Main Two-Column Layout */
        a!columnsLayout(
          columns: {
            /* Left Column - Job Listings */
            a!columnLayout(
              contents: {
                a!sectionLayout(
                  label: a!richTextDisplayField(
                    value: {
                      a!richTextIcon(
                        icon: "search",
                        color: "ACCENT"
                      ),
                      " ",
                      a!richTextItem(
                        text: "Available Positions",
                        style: "STRONG",
                        size: "MEDIUM_PLUS"
                      )
                    }
                  ),
                  contents: {
                    a!forEach(
                      items: local!jobListings,
                      expression: a!cardLayout(
                        contents: {
                          a!columnsLayout(
                            columns: {
                              a!columnLayout(
                                contents: {
                                  a!richTextDisplayField(
                                    value: {
                                      a!richTextItem(
                                        text: fv!item.jobName,
                                        size: "MEDIUM_PLUS",
                                        style: "STRONG"
                                      ),
                                      char(10),
                                      a!richTextIcon(
                                        icon: "users",
                                        size: "SMALL"
                                      ),
                                      " ",
                                      a!richTextItem(
                                        text: fv!item.vacancies & " Vacancies",
                                        size: "SMALL",
                                        color: "SECONDARY"
                                      ),
                                      " • ",
                                      a!richTextIcon(
                                        icon: "file-user",
                                        size: "SMALL"
                                      ),
                                      " ",
                                      a!richTextItem(
                                        text: fv!item.applicants & " Applicants",
                                        size: "SMALL",
                                        color: "SECONDARY"
                                      )
                                    }
                                  )
                                },
                                width: "WIDE"
                              ),
                              a!columnLayout(
                                contents: {
                                  a!tagField(
                                    tags: {
                                      a!tagItem(
                                        text: fv!item.status,
                                        backgroundColor: if(
                                          fv!item.urgent,
                                          "NEGATIVE",
                                          "POSITIVE"
                                        ),
                                        textColor: "WHITE"
                                      )
                                    },
                                    align: "RIGHT"
                                  ),
                                  a!buttonLayout(
                                    primaryButtons: {
                                      a!buttonWidget(
                                        label: "Apply Now",
                                        style: "OUTLINE",
                                        size: "SMALL",
                                        icon: "paper-plane"
                                      )
                                    },
                                    align: "RIGHT"
                                  )
                                },
                                width: "NARROW_PLUS"
                              )
                            }
                          )
                        },
                        style: "NONE",
                        decorativeBarPosition: "START",
                        decorativeBarColor: if(
                          fv!item.urgent,
                          "NEGATIVE",
                          "POSITIVE"
                        ),
                        marginBelow: "STANDARD",
                        showShadow: true,
                        showBorder: true,
                        accessibilityText: "Job: " & fv!item.jobName
                      )
                    )
                  }
                )
              },
              width: "MEDIUM_PLUS"
            ),
            
            /* Right Column - Utility Cards */
            a!columnLayout(
              contents: {
                a!sectionLayout(
                  label: a!richTextDisplayField(
                    value: {
                      a!richTextIcon(
                        icon: "tools",
                        color: "ACCENT"
                      ),
                      " ",
                      a!richTextItem(
                        text: "HR Tools",
                        style: "STRONG",
                        size: "MEDIUM_PLUS"
                      )
                    }
                  ),
                  contents: {
                    /* Bulk Resume Upload Card */
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "cloud-upload-alt",
                              size: "LARGE",
                              color: "POSITIVE"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Bulk Resume Upload",
                              size: "MEDIUM_PLUS",
                              style: "STRONG"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Upload multiple resumes at once for efficient processing",
                              size: "SMALL",
                              color: "SECONDARY"
                            )
                          },
                          align: "CENTER"
                        ),
                        a!buttonLayout(
                          primaryButtons: {
                            a!buttonWidget(
                              label: "Upload Files",
                              style: "PRIMARY",
                              icon: "upload",
                              width: "FILL"
                            )
                          }
                        )
                      },
                      style: "ACCENT",
                      backgroundColor: "POSITIVE",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false
                    ),
                    
                    /* Record Chatbot Card */
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "microphone",
                              size: "LARGE",
                              color: "ACCENT"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Record Chatbot",
                              size: "MEDIUM_PLUS",
                              style: "STRONG"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Voice-enabled assistant for HR queries and candidate interviews",
                              size: "SMALL",
                              color: "SECONDARY"
                            )
                          },
                          align: "CENTER"
                        ),
                        a!buttonLayout(
                          primaryButtons: {
                            a!buttonWidget(
                              label: "Start Recording",
                              style: "PRIMARY",
                              icon: "play",
                              width: "FILL"
                            )
                          }
                        )
                      },
                      style: "ACCENT",
                      backgroundColor: "ACCENT",
                      marginBelow: "STANDARD",
                      showShadow: true,
                      showBorder: false
                    ),
                    
                    /* Document Chatbot Card */
                    a!cardLayout(
                      contents: {
                        a!richTextDisplayField(
                          value: {
                            a!richTextIcon(
                              icon: "comments",
                              size: "LARGE",
                              color: "SECONDARY"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "Document Chatbot",
                              size: "MEDIUM_PLUS",
                              style: "STRONG"
                            ),
                            char(10),
                            a!richTextItem(
                              text: "AI-powered document analysis and HR policy assistance",
                              size: "SMALL",
                              color: "SECONDARY"
                            )
                          },
                          align: "CENTER"
                        ),
                        a!buttonLayout(
                          primaryButtons: {
                            a!buttonWidget(
                              label: "Start Chat",
                              style: "PRIMARY",
                              icon: "comment-dots",
                              width: "FILL"
                            )
                          }
                        )
                      },
                      style: "ACCENT",
                      backgroundColor: "SECONDARY",
                      marginBelow: "NONE",
                      showShadow: true,
                      showBorder: false
                    )
                  }
                )
              },
              width: "NARROW_PLUS"
            )
          },
          spacing: "MORE",
          stackWhen: {
            "PHONE",
            "TABLET_PORTRAIT"
          }
        )
      }
    )
  }
)
a!localVariables(
  /* Sample data - Replace with actual rule inputs or data queries */
  local!activeJobRoles: 45,
  local!inactiveJobRoles: 12,
  local!temporaryVacancies: 23,
  local!permanentVacancies: 67,
  local!regularOpenPositions: 34,
  local!contractOpenPositions: 18,
  
  /* Sample job data - Replace with actual CDT or query */
  local!jobData: {
    a!map(jobName: "Software Engineer", vacancies: 5, jobId: 1),
    a!map(jobName: "Product Manager", vacancies: 3, jobId: 2),
    a!map(jobName: "Data Analyst", vacancies: 4, jobId: 3),
    a!map(jobName: "UX Designer", vacancies: 2, jobId: 4),
    a!map(jobName: "Marketing Specialist", vacancies: 6, jobId: 5),
    a!map(jobName: "HR Coordinator", vacancies: 1, jobId: 6)
  },
  
  /* Chat messages for chatbot simulation */
  local!chatMessages: {
    "Welcome to HR Assistant! How can I help you today?",
    "I can help with job applications, policies, and general HR inquiries."
  },
  local!userMessage: "",
  
  a!formLayout(
    label: "HR Dashboard",
    contents: {
      /* Header KPI Section */
      a!sectionLayout(
        label: "Key Performance Indicators",
        labelHeadingTag: "H2",
        contents: {
          a!columnsLayout(
            columns: {
              /* Job Roles Status KPIs */
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Active Job Roles",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!activeJobRoles,
                          size: "LARGE",
                          style: "STRONG",
                          color: "POSITIVE"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "INFO",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              ),
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Inactive Job Roles",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!inactiveJobRoles,
                          size: "LARGE",
                          style: "STRONG",
                          color: "SECONDARY"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "WARN",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              ),
              /* Vacancy KPIs */
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Temporary Vacancies",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!temporaryVacancies,
                          size: "LARGE",
                          style: "STRONG",
                          color: "ACCENT"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "ACCENT",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              ),
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Permanent Vacancies",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!permanentVacancies,
                          size: "LARGE",
                          style: "STRONG",
                          color: "POSITIVE"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "SUCCESS",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              ),
              /* Open Position KPIs */
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Regular Open Positions",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!regularOpenPositions,
                          size: "LARGE",
                          style: "STRONG",
                          color: "STANDARD"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "STANDARD",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              ),
              a!columnLayout(
                contents: {
                  a!cardLayout(
                    contents: {
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: "Contract Open Positions",
                          size: "MEDIUM",
                          style: "STRONG"
                        ),
                        align: "CENTER"
                      ),
                      a!richTextDisplayField(
                        value: a!richTextItem(
                          text: local!contractOpenPositions,
                          size: "LARGE",
                          style: "STRONG",
                          color: "SECONDARY"
                        ),
                        align: "CENTER"
                      )
                    },
                    style: "NONE",
                    marginBelow: "STANDARD"
                  )
                },
                width: "MEDIUM"
              )
            }
          )
        }
      ),
      
      /* Main Content Section */
      a!sectionLayout(
        label: "Job Opportunities & Actions",
        labelHeadingTag: "H2",
        contents: {
          a!columnsLayout(
            columns: {
              /* First Column - Job Cards (2/3 width) */
              a!columnLayout(
                contents: {
                  a!sectionLayout(
                    label: "Available Positions",
                    labelHeadingTag: "H3",
                    contents: {
                      /* First Row - 3 Job Cards */
                      a!columnsLayout(
                        columns: {
                          a!forEach(
                            items: a!flatten({local!jobData[1], local!jobData[2], local!jobData[3]}),
                            expression: a!columnLayout(
                              contents: {
                                a!cardLayout(
                                  contents: {
                                    a!richTextDisplayField(
                                      value: a!richTextItem(
                                        text: fv!item.jobName,
                                        size: "MEDIUM",
                                        style: "STRONG"
                                      ),
                                      align: "CENTER"
                                    ),
                                    a!richTextDisplayField(
                                      value: {
                                        a!richTextItem(
                                          text: "Vacancies: ",
                                          style: "PLAIN"
                                        ),
                                        a!richTextItem(
                                          text: fv!item.vacancies,
                                          style: "STRONG",
                                          color: "ACCENT"
                                        )
                                      },
                                      align: "CENTER",
                                      marginBelow: "STANDARD"
                                    ),
                                    a!buttonArrayLayout(
                                      buttons: {
                                        a!buttonWidget(
                                          label: "Apply Now",
                                          style: "PRIMARY",
                                          size: "SMALL",
                                          saveInto: {
                                            a!save(
                                              local!userMessage,
                                              "Application initiated for " & fv!item.jobName
                                            )
                                          }
                                        )
                                      },
                                      align: "CENTER"
                                    )
                                  },
                                  style: "STANDARD",
                                  marginBelow: "STANDARD"
                                )
                              },
                              width: "MEDIUM"
                            )
                          )
                        }
                      ),
                      /* Second Row - 3 Job Cards */
                      a!columnsLayout(
                        columns: {
                          a!forEach(
                            items: a!flatten({local!jobData[4], local!jobData[5], local!jobData[6]}),
                            expression: a!columnLayout(
                              contents: {
                                a!cardLayout(
                                  contents: {
                                    a!richTextDisplayField(
                                      value: a!richTextItem(
                                        text: fv!item.jobName,
                                        size: "MEDIUM",
                                        style: "STRONG"
                                      ),
                                      align: "CENTER"
                                    ),
                                    a!richTextDisplayField(
                                      value: {
                                        a!richTextItem(
                                          text: "Vacancies: ",
                                          style: "PLAIN"
                                        ),
                                        a!richTextItem(
                                          text: fv!item.vacancies,
                                          style: "STRONG",
                                          color: "ACCENT"
                                        )
                                      },
                                      align: "CENTER",
                                      marginBelow: "STANDARD"
                                    ),
                                    a!buttonArrayLayout(
                                      buttons: {
                                        a!buttonWidget(
                                          label: "Apply Now",
                                          style: "PRIMARY",
                                          size: "SMALL",
                                          saveInto: {
                                            a!save(
                                              local!userMessage,
                                              "Application initiated for " & fv!item.jobName
                                            )
                                          }
                                        )
                                      },
                                      align: "CENTER"
                                    )
                                  },
                                  style: "STANDARD",
                                  marginBelow: "STANDARD"
                                )
                              },
                              width: "MEDIUM"
                            )
                          )
                        }
                      )
                    }
                  )
                },
                width: "WIDE"
              ),
              
              /* Second Column - Action Cards (1/3 width) */
              a!columnLayout(
                contents: {
                  a!sectionLayout(
                    label: "Quick Actions",
                    labelHeadingTag: "H3",
                    contents: {
                      /* Bulk Upload Card */
                      a!cardLayout(
                        contents: {
                          a!richTextDisplayField(
                            value: a!richTextItem(
                              text: "Bulk Upload",
                              size: "MEDIUM",
                              style: "STRONG"
                            ),
                            align: "CENTER"
                          ),
                          a!richTextDisplayField(
                            value: a!richTextItem(
                              text: "Upload multiple job postings or candidate resumes",
                              style: "PLAIN"
                            ),
                            align: "CENTER",
                            marginBelow: "STANDARD"
                          ),
                          a!buttonArrayLayout(
                            buttons: {
                              a!buttonWidget(
                                label: "Upload Files",
                                style: "SECONDARY",
                                icon: "upload",
                                saveInto: {
                                  /* Add your bulk upload logic here */
                                  a!save(
                                    local!userMessage,
                                    "Bulk upload initiated"
                                  )
                                }
                              )
                            },
                            align: "CENTER"
                          )
                        },
                        style: "INFO",
                        marginBelow: "STANDARD"
                      ),
                      
                      /* HR Chatbot Card */
                      a!cardLayout(
                        contents: {
                          a!richTextDisplayField(
                            value: a!richTextItem(
                              text: "HR Assistant Chatbot",
                              size: "MEDIUM",
                              style: "STRONG"
                            ),
                            align: "CENTER"
                          ),
                          a!sectionLayout(
                            contents: {
                              a!richTextDisplayField(
                                value: a!forEach(
                                  items: local!chatMessages,
                                  expression: a!richTextItem(
                                    text: fv!item & char(10),
                                    style: if(fv!index = 1, "STRONG", "PLAIN"),
                                    color: if(fv!index = 1, "ACCENT", "STANDARD")
                                  )
                                ),
                                marginBelow: "STANDARD"
                              ),
                              a!textField(
                                label: "Type your message",
                                labelPosition: "COLLAPSED",
                                placeholder: "Ask me anything about HR policies...",
                                value: local!userMessage,
                                saveInto: local!userMessage,
                                refreshAfter: "UNFOCUS"
                              ),
                              a!buttonArrayLayout(
                                buttons: {
                                  a!buttonWidget(
                                    label: "Send",
                                    style: "PRIMARY",
                                    size: "SMALL",
                                    icon: "send",
                                    saveInto: {
                                      a!save(
                                        local!chatMessages,
                                        append(
                                          local!chatMessages,
                                          "You: " & local!userMessage
                                        )
                                      ),
                                      a!save(
                                        local!chatMessages,
                                        append(
                                          local!chatMessages,
                                          "Bot: I received your message: '" & local!userMessage & "'. How else can I assist you?"
                                        )
                                      ),
                                      a!save(local!userMessage, "")
                                    }
                                  )
                                },
                                align: "START"
                              )
                            },
                            marginBelow: "STANDARD"
                          )
                        },
                        style: "SUCCESS",
                        marginBelow: "STANDARD"
                      ),
                      
                      /* Records Management Card */
                      a!cardLayout(
                        contents: {
                          a!richTextDisplayField(
                            value: a!richTextItem(
                              text: "Records Management",
                              size: "MEDIUM",
                              style: "STRONG"
                            ),
                            align: "CENTER"
                          ),
                          a!richTextDisplayField(
                            value: a!richTextItem(
                              text: "Manage employee records, applications, and documentation",
                              style: "PLAIN"
                            ),
                            align: "CENTER",
                            marginBelow: "STANDARD"
                          ),
                          a!buttonArrayLayout(
                            buttons: {
                              a!buttonWidget(
                                label: "View Records",
                                style: "OUTLINE",
                                icon: "file-text",
                                size: "SMALL",
                                saveInto: {
                                  /* Add your records management logic here */
                                  a!save(
                                    local!userMessage,
                                    "Records management accessed"
                                  )
                                }
                              ),
                              a!buttonWidget(
                                label: "Create Record",
                                style: "OUTLINE",
                                icon: "plus",
                                size: "SMALL",
                                saveInto: {
                                  /* Add your create record logic here */
                                  a!save(
                                    local!userMessage,
                                    "New record creation initiated"
                                  )
                                }
                              )
                            },
                            align: "CENTER"
                          )
                        },
                        style: "ACCENT"
                      )
                    }
                  )
                },
                width: "NARROW"
              )
            }
          )
        }
      )
    },
    buttons: a!buttonLayout(
      primaryButtons: {
        a!buttonWidget(
          label: "Refresh Dashboard",
          style: "OUTLINE",
          icon: "refresh",
          saveInto: {
            /* Add refresh logic here */
            a!save(local!userMessage, "Dashboard refreshed")
          }
        )
      },
      secondaryButtons: {
        a!buttonWidget(
          label: "Export Data",
          style: "OUTLINE",
          icon: "download",
          saveInto: {
            /* Add export logic here */
            a!save(local!userMessage, "Data export initiated")
          }
        )
      }
    )
  )
)
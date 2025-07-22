/* Appian SAIL Interface for AI Resume Job Matcher */

a!localVariables(
  /* State Management Variables */
  local!resumeText: "",
  local!isAnalyzing: false,
  local!recommendedJobs: {},
  local!selectedJobIds: {},
  local!showResults: false,
  local!errorMessage: "",
  
  a!formLayout(
    label: "AI-Powered Resume Job Matcher",
    instructions: "Upload your resume and let our AI find the perfect job matches for you",
    contents: {
      
      /* Resume Upload and Analysis Section */
      a!sectionLayout(
        label: "Step 1: Resume Analysis",
        contents: {
          a!textField(
            label: "Resume Content",
            labelPosition: "ABOVE",
            placeholder: "Paste your resume text here...",
            value: local!resumeText,
            saveInto: local!resumeText,
            height: "TALL",
            required: true
          ),
          a!buttonArrayLayout(
            buttons: {
              a!buttonWidget(
                label: "Analyze Resume with AI",
                icon: "search",
                style: "PRIMARY",
                size: "STANDARD",
                loadingIndicator: local!isAnalyzing,
                disabled: or(local!isAnalyzing, isnull(local!resumeText)),
                saveInto: {
                  a!save(local!isAnalyzing, true),
                  a!save(local!errorMessage, ""),
                  /* Call AI Skill here - replace with actual implementation */
                  /* rule!AI_AnalyzeResume(resumeText: local!resumeText) */
                  a!save(local!recommendedJobs, {
                    {
                      jobId: 1,
                      jobName: "Senior Software Engineer",
                      department: "Engineering",
                      location: "Remote",
                      matchingSkills: {"Java", "Spring Boot", "React", "AWS", "Microservices"},
                      matchScore: 92,
                      jobDescription: "Lead development of scalable web applications and mentor junior developers.",
                      requirements: {"5+ years Java experience", "Bachelor's in CS", "Leadership skills"},
                      salaryRange: "$120,000 - $150,000"
                    },
                    {
                      jobId: 2,
                      jobName: "Full Stack Developer",
                      department: "Technology", 
                      location: "New York, NY",
                      matchingSkills: {"JavaScript", "Node.js", "React", "MongoDB"},
                      matchScore: 87,
                      jobDescription: "Develop and maintain web applications across the full technology stack.",
                      requirements: {"3+ years experience", "Modern JS frameworks", "Database design"},
                      salaryRange: "$90,000 - $120,000"
                    },
                    {
                      jobId: 3,
                      jobName: "DevOps Engineer",
                      department: "Infrastructure",
                      location: "San Francisco, CA", 
                      matchingSkills: {"AWS", "Docker", "Kubernetes", "CI/CD"},
                      matchScore: 78,
                      jobDescription: "Manage cloud infrastructure and implement DevOps best practices.",
                      requirements: {"AWS certification", "Container orchestration", "Infrastructure as Code"},
                      salaryRange: "$110,000 - $140,000"
                    }
                  }),
                  a!save(local!showResults, true),
                  a!save(local!isAnalyzing, false)
                }
              ),
              a!buttonWidget(
                label: "Clear All",
                icon: "times", 
                style: "SECONDARY",
                saveInto: {
                  a!save(local!resumeText, ""),
                  a!save(local!recommendedJobs, {}),
                  a!save(local!showResults, false),
                  a!save(local!selectedJobIds, {}),
                  a!save(local!errorMessage, "")
                }
              )
            },
            align: "START"
          )
        },
        showBorder: true
      ),
      
      /* Job Recommendations Section */
      if(
        local!showResults and length(local!recommendedJobs) > 0,
        a!sectionLayout(
          label: "Step 2: Job Recommendations (" & length(local!recommendedJobs) & " matches found)",
          contents: {
            a!stampField(
              labelPosition: "COLLAPSED",
              text: "Great! Our AI found " & length(local!recommendedJobs) & " job(s) that match your profile:",
              backgroundColor: "POSITIVE",
              contentColor: "STANDARD",
              size: "SMALL"
            ),
            
            /* Job Cards */
            a!forEach(
              items: local!recommendedJobs,
              expression: a!cardLayout(
                contents: {
                  /* Job Header */
                  a!columnsLayout(
                    columns: {
                      a!columnLayout(
                        contents: {
                          a!richTextDisplayField(
                            labelPosition: "COLLAPSED",
                            value: {
                              a!richTextItem(
                                text: fv!item.jobName,
                                size: "LARGE",
                                style: "STRONG",
                                color: "ACCENT"
                              ),
                              char(10),
                              a!richTextItem(
                                text: fv!item.department & " • " & fv!item.location,
                                color: "SECONDARY"
                              ),
                              char(10),
                              a!richTextItem(
                                text: fv!item.salaryRange,
                                color: "SECONDARY",
                                size: "SMALL"
                              )
                            }
                          )
                        },
                        width: "WIDE"
                      ),
                      a!columnLayout(
                        contents: {
                          a!gaugeField(
                            label: "Match Score",
                            labelPosition: "ABOVE",
                            percentage: fv!item.matchScore,
                            primaryText: fv!item.matchScore & "%",
                            color: if(
                              fv!item.matchScore >= 90,
                              "POSITIVE",
                              if(fv!item.matchScore >= 80, "ACCENT", "STANDARD")
                            ),
                            size: "MEDIUM"
                          )
                        },
                        width: "NARROW"
                      )
                    }
                  ),
                  
                  /* Job Description */
                  a!textField(
                    label: "Job Description",
                    labelPosition: "ABOVE",
                    value: fv!item.jobDescription,
                    readOnly: true,
                    height: "SHORT"
                  ),
                  
                  /* Matching Skills */
                  a!richTextDisplayField(
                    label: "Your Matching Skills",
                    labelPosition: "ABOVE", 
                    value: a!forEach(
                      items: fv!item.matchingSkills,
                      expression: {
                        a!richTextItem(
                          text: " " & fv!item & " ",
                          backgroundColor: "ACCENT",
                          style: "STRONG",
                          size: "SMALL"
                        ),
                        "  "
                      }
                    )
                  ),
                  
                  /* Requirements */
                  a!textField(
                    label: "Key Requirements",
                    labelPosition: "ABOVE",
                    value: joinarray(fv!item.requirements, " • "),
                    readOnly: true
                  ),
                  
                  /* Action Buttons */
                  a!buttonArrayLayout(
                    buttons: {
                      a!buttonWidget(
                        label: if(
                          contains(fv!item.jobId, local!selectedJobIds),
                          "Applied ✓",
                          "Apply Now"
                        ),
                        style: if(
                          contains(fv!item.jobId, local!selectedJobIds),
                          "DESTRUCTIVE",
                          "PRIMARY"
                        ),
                        disabled: contains(fv!item.jobId, local!selectedJobIds),
                        saveInto: {
                          a!save(
                            local!selectedJobIds,
                            append(local!selectedJobIds, fv!item.jobId)
                          )
                          /* In real implementation: rule!JOB_SubmitApplication() */
                        }
                      ),
                      a!buttonWidget(
                        label: "View Details",
                        style: "SECONDARY",
                        saveInto: {
                          /* Open job details dialog */
                          /* a!startProcess() for job details workflow */
                        }
                      ),
                      a!buttonWidget(
                        label: "Save for Later",
                        style: "SECONDARY",
                        saveInto: {
                          /* Save job to bookmarks */
                          /* rule!JOB_SaveJob() */
                        }
                      ),
                      a!buttonWidget(
                        label: "Cancel",
                        style: "OUTLINE",
                        saveInto: {
                          /* Remove from recommendations */
                          a!save(
                            local!recommendedJobs,
                            remove(
                              local!recommendedJobs,
                              wherecontains(fv!item.jobId, local!recommendedJobs.jobId)
                            )
                          )
                        }
                      )
                    },
                    align: "START"
                  )
                },
                style: if(
                  contains(fv!item.jobId, local!selectedJobIds),
                  "INFO",
                  "STANDARD"
                ),
                marginBelow: "STANDARD",
                showBorder: true
              )
            )
          },
          showBorder: true
        ),
        {}
      ),
      
      /* Application Summary */
      if(
        length(local!selectedJobIds) > 0,
        a!sectionLayout(
          label: "Application Summary",
          contents: {
            a!stampField(
              labelPosition: "COLLAPSED",
              text: "You have applied to " & length(local!selectedJobIds) & " position(s). HR will review your applications within 3-5 business days.",
              backgroundColor: "POSITIVE",
              contentColor: "STANDARD"
            ),
            a!buttonWidget(
              label: "View My Applications",
              style: "SECONDARY",
              saveInto: {
                /* Navigate to applications page */
              }
            )
          },
          showBorder: true
        ),
        {}
      )
    },
    
    /* Form Footer */
    buttons: a!buttonLayout(
      primaryButtons: {
        a!buttonWidget(
          label: "Complete",
          style: "PRIMARY",
          saveInto: {
            /* Finalize and submit */
          }
        )
      },
      secondaryButtons: {
        a!buttonWidget(
          label: "Return to Dashboard", 
          style: "SECONDARY",
          saveInto: {
            /* Navigate back */
          }
        )
      }
    )
  )
)

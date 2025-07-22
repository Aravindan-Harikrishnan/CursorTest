/* Enhanced Appian SAIL Interface for AI Resume Job Matcher
   Includes advanced features and comprehensive job recommendation display */

a!localVariables(
  /* State Management */
  local!resumeText: "",
  local!uploadedFile: {},
  local!isAnalyzing: false,
  local!recommendedJobs: {},
  local!selectedJobIds: {},
  local!savedJobIds: {},
  local!showResults: false,
  local!showFilters: false,
  local!errorMessage: "",
  local!successMessage: "",
  local!analysisInsights: {},
  
  /* Filter Variables */
  local!filterDepartments: {},
  local!filterLocations: {},
  local!filterSalaryMin: 0,
  local!filterSalaryMax: 200000,
  local!filterMatchScore: 70,
  local!filterRemoteOnly: false,
  
  a!formLayout(
    label: "AI-Powered Resume Job Matcher",
    instructions: "Upload your resume and discover personalized job opportunities within our organization",
    contents: {
      
      /* Success/Error Messages */
      if(
        not(isnull(local!successMessage)) and len(local!successMessage) > 0,
        a!stampField(
          labelPosition: "COLLAPSED",
          text: local!successMessage,
          backgroundColor: "POSITIVE",
          contentColor: "STANDARD",
          size: "MEDIUM",
          marginBelow: "STANDARD"
        ),
        {}
      ),
      
      if(
        not(isnull(local!errorMessage)) and len(local!errorMessage) > 0,
        a!stampField(
          labelPosition: "COLLAPSED", 
          text: local!errorMessage,
          backgroundColor: "NEGATIVE",
          contentColor: "STANDARD",
          size: "MEDIUM",
          marginBelow: "STANDARD"
        ),
        {}
      ),
      
      /* Resume Upload Section */
      a!sectionLayout(
        label: "Step 1: Resume Analysis",
        contents: {
          a!columnsLayout(
            columns: {
              a!columnLayout(
                contents: {
                  a!fileUploadField(
                    label: "Upload Resume File",
                    labelPosition: "ABOVE",
                    instructions: "Supported formats: PDF, DOC, DOCX",
                    target: cons!RESUME_UPLOAD_FOLDER,
                    maxSelections: 1,
                    buttonStyle: "OUTLINE",
                    value: local!uploadedFile,
                    saveInto: local!uploadedFile
                  )
                },
                width: "MEDIUM"
              ),
              a!columnLayout(
                contents: {
                  a!richTextDisplayField(
                    labelPosition: "COLLAPSED",
                    value: {
                      a!richTextItem(text: "OR", style: "STRONG", size: "LARGE"),
                      char(10),
                      a!richTextItem(text: "Paste resume text in the field below", color: "SECONDARY")
                    },
                    align: "CENTER"
                  )
                },
                width: "NARROW"
              ),
              a!columnLayout(
                contents: {},
                width: "MEDIUM"
              )
            }
          ),
          a!textField(
            label: "Resume Content",
            labelPosition: "ABOVE",
            placeholder: "Paste your complete resume text here including work experience, skills, education, and achievements...",
            value: local!resumeText,
            saveInto: local!resumeText,
            height: "TALL",
            required: and(
              isnull(local!uploadedFile),
              or(isnull(local!resumeText), len(trim(local!resumeText)) = 0)
            )
          ),
          a!buttonArrayLayout(
            buttons: {
              a!buttonWidget(
                label: "Analyze Resume with AI",
                icon: "magic",
                style: "PRIMARY",
                size: "STANDARD",
                loadingIndicator: local!isAnalyzing,
                disabled: or(
                  local!isAnalyzing,
                  and(
                    isnull(local!uploadedFile),
                    or(isnull(local!resumeText), len(trim(local!resumeText)) < 50)
                  )
                ),
                saveInto: {
                  a!save(local!isAnalyzing, true),
                  a!save(local!errorMessage, ""),
                  a!save(local!successMessage, ""),
                  /* Process uploaded file if present */
                  if(
                    not(isnull(local!uploadedFile)),
                    a!save(local!resumeText, rule!EXTRACT_TextFromFile(local!uploadedFile)),
                    {}
                  ),
                  /* Call AI Analysis */
                  a!localVariables(
                    local!aiResult: rule!AI_AnalyzeResume(
                      resumeText: local!resumeText,
                      candidateId: ri!candidateId
                    ),
                    if(
                      local!aiResult.success,
                      {
                        a!save(local!recommendedJobs, local!aiResult.jobRecommendations),
                        a!save(local!analysisInsights, local!aiResult.analysisInsights),
                        a!save(local!showResults, true),
                        a!save(local!successMessage, "Resume analyzed successfully! Found " & length(local!aiResult.jobRecommendations) & " matching opportunities.")
                      },
                      {
                        a!save(local!errorMessage, local!aiResult.errorMessage),
                        a!save(local!showResults, false)
                      }
                    )
                  ),
                  a!save(local!isAnalyzing, false)
                }
              ),
              a!buttonWidget(
                label: "Clear All",
                icon: "trash",
                style: "SECONDARY", 
                saveInto: {
                  a!save(local!resumeText, ""),
                  a!save(local!uploadedFile, {}),
                  a!save(local!recommendedJobs, {}),
                  a!save(local!showResults, false),
                  a!save(local!selectedJobIds, {}),
                  a!save(local!savedJobIds, {}),
                  a!save(local!errorMessage, ""),
                  a!save(local!successMessage, ""),
                  a!save(local!analysisInsights, {})
                }
              )
            },
            align: "START"
          )
        },
        isCollapsible: false,
        showBorder: true
      ),
      
      /* Analysis Insights Section */
      if(
        local!showResults and not(isnull(local!analysisInsights)),
        a!sectionLayout(
          label: "Resume Analysis Insights",
          contents: {
            a!columnsLayout(
              columns: {
                a!columnLayout(
                  contents: {
                    a!richTextDisplayField(
                      label: "Top Skills Identified",
                      labelPosition: "ABOVE",
                      value: a!forEach(
                        items: local!analysisInsights.topSkillsIdentified,
                        expression: {
                          a!richTextItem(
                            text: " " & fv!item & " ",
                            backgroundColor: "POSITIVE",
                            style: "STRONG",
                            size: "SMALL"
                          ),
                          "  "
                        }
                      )
                    )
                  },
                  width: "WIDE"
                ),
                a!columnLayout(
                  contents: {
                    a!textField(
                      label: "Experience Level",
                      value: local!analysisInsights.experienceLevel,
                      readOnly: true
                    ),
                    a!textField(
                      label: "Industry Alignment",
                      value: local!analysisInsights.industryAlignment,
                      readOnly: true
                    )
                  },
                  width: "NARROW"
                )
              }
            ),
            if(
              not(isnull(local!analysisInsights.recommendedImprovements)),
              a!richTextDisplayField(
                label: "Resume Enhancement Suggestions",
                labelPosition: "ABOVE",
                value: a!forEach(
                  items: local!analysisInsights.recommendedImprovements,
                  expression: {
                    a!richTextItem(text: "• ", color: "ACCENT"),
                    a!richTextItem(text: fv!item),
                    char(10)
                  }
                )
              ),
              {}
            )
          },
          isCollapsible: true,
          isInitiallyCollapsed: true,
          showBorder: true
        ),
        {}
      ),
      
      /* Filters Section */
      if(
        local!showResults and length(local!recommendedJobs) > 0,
        a!sectionLayout(
          label: "Filter Recommendations",
          contents: {
            a!columnsLayout(
              columns: {
                a!columnLayout(
                  contents: {
                    a!checkboxField(
                      label: "Show Remote Jobs Only",
                      choiceLabels: {"Remote positions only"},
                      choiceValues: {true},
                      value: if(local!filterRemoteOnly, {true}, {}),
                      saveInto: a!save(local!filterRemoteOnly, contains(true, save!value))
                    )
                  },
                  width: "NARROW"
                ),
                a!columnLayout(
                  contents: {
                    a!integerField(
                      label: "Minimum Match Score",
                      value: local!filterMatchScore,
                      saveInto: local!filterMatchScore,
                      min: 60,
                      max: 100
                    )
                  },
                  width: "NARROW"
                ),
                a!columnLayout(
                  contents: {
                    a!dropdownField(
                      label: "Department",
                      placeholder: "All Departments",
                      choiceLabels: rule!GET_DepartmentList(),
                      choiceValues: rule!GET_DepartmentList(),
                      value: local!filterDepartments,
                      saveInto: local!filterDepartments,
                      multiple: true
                    )
                  },
                  width: "MEDIUM"
                )
              }
            )
          },
          isCollapsible: true,
          isInitiallyCollapsed: true,
          showBorder: true
        ),
        {}
      ),
      
      /* Job Recommendations Section */
      if(
        local!showResults and length(local!recommendedJobs) > 0,
        a!sectionLayout(
          label: "Job Recommendations (" & 
                 length(
                   rule!FILTER_JobRecommendations(
                     jobs: local!recommendedJobs,
                     filters: {
                       departments: local!filterDepartments,
                       minMatchScore: local!filterMatchScore,
                       remoteOnly: local!filterRemoteOnly
                     }
                   )
                 ) & " of " & length(local!recommendedJobs) & " matches)",
          contents: {
            a!forEach(
              items: rule!FILTER_JobRecommendations(
                jobs: local!recommendedJobs,
                filters: {
                  departments: local!filterDepartments,
                  minMatchScore: local!filterMatchScore,
                  remoteOnly: local!filterRemoteOnly
                }
              ),
              expression: a!cardLayout(
                contents: {
                  /* Job Header with Match Score */
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
                                color: "SECONDARY",
                                size: "MEDIUM"
                              ),
                              char(10),
                              a!richTextItem(
                                text: fv!item.employmentType & " • " & fv!item.salaryRange,
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
                              if(
                                fv!item.matchScore >= 80,
                                "ACCENT",
                                if(
                                  fv!item.matchScore >= 70,
                                  "STANDARD",
                                  "SECONDARY"
                                )
                              )
                            ),
                            size: "MEDIUM"
                          ),
                          if(
                            fv!item.urgency = "HIGH",
                            a!stampField(
                              labelPosition: "COLLAPSED",
                              text: "🔥 Urgent Hiring",
                              backgroundColor: "NEGATIVE",
                              size: "SMALL",
                              align: "CENTER"
                            ),
                            {}
                          )
                        },
                        width: "NARROW"
                      )
                    }
                  ),
                  
                  /* Job Description */
                  a!richTextDisplayField(
                    label: "Job Description",
                    labelPosition: "ABOVE",
                    value: a!richTextItem(text: fv!item.jobDescription)
                  ),
                  
                  /* Matching Skills with Visual Emphasis */
                  a!richTextDisplayField(
                    label: "Your Matching Skills (" & length(fv!item.matchingSkills) & " skills match)",
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
                  
                  /* Requirements and Benefits */
                  a!columnsLayout(
                    columns: {
                      a!columnLayout(
                        contents: {
                          a!richTextDisplayField(
                            label: "Key Requirements",
                            labelPosition: "ABOVE",
                            value: a!forEach(
                              items: fv!item.requirements,
                              expression: {
                                a!richTextItem(text: "• ", color: "ACCENT"),
                                a!richTextItem(text: fv!item),
                                char(10)
                              }
                            )
                          )
                        },
                        width: "MEDIUM"
                      ),
                      a!columnLayout(
                        contents: {
                          if(
                            not(isnull(fv!item.benefits)),
                            a!richTextDisplayField(
                              label: "Benefits & Perks",
                              labelPosition: "ABOVE",
                              value: a!forEach(
                                items: fv!item.benefits,
                                expression: {
                                  a!richTextItem(text: "✓ ", color: "POSITIVE"),
                                  a!richTextItem(text: fv!item),
                                  char(10)
                                }
                              )
                            ),
                            {}
                          )
                        },
                        width: "MEDIUM"
                      )
                    }
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
                        icon: if(
                          contains(fv!item.jobId, local!selectedJobIds),
                          "check-circle",
                          "paper-plane"
                        ),
                        style: if(
                          contains(fv!item.jobId, local!selectedJobIds),
                          "DESTRUCTIVE",
                          "PRIMARY"
                        ),
                        disabled: contains(fv!item.jobId, local!selectedJobIds),
                        saveInto: {
                          a!localVariables(
                            local!applicationResult: rule!JOB_SubmitApplication(
                              jobId: fv!item.jobId,
                              candidateId: ri!candidateId
                            ),
                            if(
                              local!applicationResult.success,
                              {
                                a!save(
                                  local!selectedJobIds,
                                  append(local!selectedJobIds, fv!item.jobId)
                                ),
                                a!save(
                                  local!successMessage,
                                  local!applicationResult.message
                                )
                              },
                              a!save(local!errorMessage, local!applicationResult.message)
                            )
                          )
                        }
                      ),
                      a!buttonWidget(
                        label: "View Full Details",
                        icon: "eye",
                        style: "SECONDARY",
                        saveInto: {
                          /* Open detailed job view */
                          a!startProcess(
                            processModel: cons!PM_JOB_DETAILS_VIEWER,
                            processParameters: {
                              jobId: fv!item.jobId,
                              candidateId: ri!candidateId,
                              source: "AI_RECOMMENDATION"
                            }
                          )
                        }
                      ),
                      a!buttonWidget(
                        label: if(
                          contains(fv!item.jobId, local!savedJobIds),
                          "Saved ★",
                          "Save for Later"
                        ),
                        icon: if(
                          contains(fv!item.jobId, local!savedJobIds),
                          "star",
                          "bookmark"
                        ),
                        style: if(
                          contains(fv!item.jobId, local!savedJobIds),
                          "DESTRUCTIVE",
                          "SECONDARY"
                        ),
                        saveInto: if(
                          contains(fv!item.jobId, local!savedJobIds),
                          a!save(
                            local!savedJobIds,
                            remove(local!savedJobIds, wherecontains(fv!item.jobId, local!savedJobIds))
                          ),
                          {
                            a!save(
                              local!savedJobIds,
                              append(local!savedJobIds, fv!item.jobId)
                            ),
                            rule!JOB_SaveForLater(
                              jobId: fv!item.jobId,
                              candidateId: ri!candidateId
                            )
                          }
                        )
                      ),
                      a!buttonWidget(
                        label: "Not Interested",
                        icon: "times",
                        style: "OUTLINE",
                        saveInto: {
                          a!save(
                            local!recommendedJobs,
                            remove(
                              local!recommendedJobs,
                              wherecontains(fv!item.jobId, local!recommendedJobs.jobId)
                            )
                          ),
                          rule!JOB_MarkNotInterested(
                            jobId: fv!item.jobId,
                            candidateId: ri!candidateId
                          )
                        }
                      )
                    },
                    align: "START",
                    marginAbove: "STANDARD"
                  )
                },
                style: if(
                  contains(fv!item.jobId, local!selectedJobIds),
                  "INFO",
                  "STANDARD"
                ),
                marginBelow: "STANDARD",
                showBorder: true,
                showShadow: true
              )
            )
          },
          isCollapsible: true,
          isInitiallyCollapsed: false,
          showBorder: true
        ),
        
        /* No Results Message */
        if(
          local!showResults and length(local!recommendedJobs) = 0,
          a!sectionLayout(
            label: "No Job Matches Found",
            contents: {
              a!columnsLayout(
                columns: {
                  a!columnLayout(
                    contents: {
                      a!imageField(
                        labelPosition: "COLLAPSED",
                        images: a!documentImage(
                          document: cons!IMG_NO_RESULTS,
                          altText: "No results found"
                        ),
                        size: "MEDIUM"
                      )
                    },
                    width: "NARROW"
                  ),
                  a!columnLayout(
                    contents: {
                      a!richTextDisplayField(
                        labelPosition: "COLLAPSED",
                        value: {
                          a!richTextItem(
                            text: "No suitable job openings found",
                            size: "LARGE",
                            style: "STRONG"
                          ),
                          char(10), char(10),
                          a!richTextItem(
                            text: "Don't worry! Here are some suggestions:",
                            color: "SECONDARY"
                          ),
                          char(10),
                          a!richTextItem(text: "• Update and enhance your resume"),
                          char(10),
                          a!richTextItem(text: "• Check back regularly for new opportunities"),
                          char(10),
                          a!richTextItem(text: "• Explore skills development programs"),
                          char(10),
                          a!richTextItem(text: "• Set up job alerts for future openings")
                        }
                      ),
                      a!buttonArrayLayout(
                        buttons: {
                          a!buttonWidget(
                            label: "Browse All Jobs",
                            style: "PRIMARY",
                            saveInto: {
                              /* Navigate to job search */
                            }
                          ),
                          a!buttonWidget(
                            label: "Get Resume Tips",
                            style: "SECONDARY",
                            saveInto: {
                              /* Navigate to resume resources */
                            }
                          ),
                          a!buttonWidget(
                            label: "Contact HR",
                            style: "OUTLINE",
                            saveInto: {
                              /* Open HR contact form */
                            }
                          )
                        },
                        align: "START"
                      )
                    },
                    width: "WIDE"
                  )
                }
              )
            },
            showBorder: true
          ),
          {}
        )
      ),
      
      /* Application Summary & Next Steps */
      if(
        length(local!selectedJobIds) > 0,
        a!sectionLayout(
          label: "Application Summary & Next Steps",
          contents: {
            a!stampField(
              labelPosition: "COLLAPSED",
              text: "🎉 Congratulations! You have successfully applied to " & length(local!selectedJobIds) & " position(s).",
              backgroundColor: "POSITIVE",
              contentColor: "STANDARD",
              size: "MEDIUM"
            ),
            a!richTextDisplayField(
              label: "What happens next?",
              labelPosition: "ABOVE",
              value: {
                a!richTextItem(text: "1. ", style: "STRONG"),
                a!richTextItem(text: "Your applications are being reviewed by our HR team"),
                char(10),
                a!richTextItem(text: "2. ", style: "STRONG"), 
                a!richTextItem(text: "You'll receive email confirmations for each application"),
                char(10),
                a!richTextItem(text: "3. ", style: "STRONG"),
                a!richTextItem(text: "Hiring managers will contact you within 3-5 business days"),
                char(10),
                a!richTextItem(text: "4. ", style: "STRONG"),
                a!richTextItem(text: "Track your application status in the candidate portal")
              }
            ),
            a!buttonArrayLayout(
              buttons: {
                a!buttonWidget(
                  label: "View My Applications",
                  icon: "list-ul",
                  style: "PRIMARY",
                  saveInto: {
                    /* Navigate to application tracking */
                  }
                ),
                a!buttonWidget(
                  label: "Continue Job Search",
                  icon: "search",
                  style: "SECONDARY",
                  saveInto: {
                    /* Reset for new search */
                    a!save(local!showResults, false),
                    a!save(local!recommendedJobs, {}),
                    a!save(local!resumeText, ""),
                    a!save(local!uploadedFile, {}),
                    a!save(local!selectedJobIds, {}),
                    a!save(local!successMessage, "")
                  }
                ),
                a!buttonWidget(
                  label: "Download Applications",
                  icon: "download", 
                  style: "OUTLINE",
                  saveInto: {
                    /* Generate application summary PDF */
                    rule!GENERATE_ApplicationSummary(
                      candidateId: ri!candidateId,
                      jobIds: local!selectedJobIds
                    )
                  }
                )
              },
              align: "START"
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
        if(
          and(local!showResults, length(local!selectedJobIds) > 0),
          a!buttonWidget(
            label: "Complete & Submit All Applications",
            icon: "check-circle",
            style: "PRIMARY",
            saveInto: {
              /* Finalize all applications */
              rule!JOB_FinalizeApplicationBatch(
                jobIds: local!selectedJobIds,
                candidateId: ri!candidateId
              )
            }
          ),
          {}
        )
      },
      secondaryButtons: {
        a!buttonWidget(
          label: "Return to Dashboard",
          icon: "home",
          style: "SECONDARY",
          saveInto: {
            /* Navigate to main dashboard */
          }
        ),
        a!buttonWidget(
          label: "Save Progress",
          icon: "save",
          style: "OUTLINE",
          saveInto: {
            /* Save current session */
            rule!CANDIDATE_SaveJobSearchSession(
              candidateId: ri!candidateId,
              sessionData: {
                resumeText: local!resumeText,
                recommendedJobs: local!recommendedJobs,
                selectedJobs: local!selectedJobIds,
                savedJobs: local!savedJobIds,
                timestamp: now()
              }
            )
          }
        )
      }
    )
  )
)

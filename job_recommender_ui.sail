a!localVariables(
  /* Sample recommended jobs data - replace with actual AI Skill output */
  local!recommendedJobs: {
    {
      jobId: 1,
      jobName: "Senior Software Engineer",
      department: "Engineering",
      location: "Remote",
      matchingSkills: {"Java", "Spring Boot", "React", "AWS", "Microservices", "Docker"},
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
      matchingSkills: {"JavaScript", "Node.js", "React", "MongoDB", "Express"},
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
      matchingSkills: {"AWS", "Docker", "Kubernetes", "CI/CD", "Terraform"},
      matchScore: 78,
      jobDescription: "Manage cloud infrastructure and implement DevOps best practices.",
      requirements: {"AWS certification", "Container orchestration", "Infrastructure as Code"},
      salaryRange: "$110,000 - $140,000"
    },
    {
      jobId: 4,
      jobName: "Frontend Developer",
      department: "User Experience",
      location: "Austin, TX",
      matchingSkills: {"React", "TypeScript", "CSS3", "HTML5", "Responsive Design"},
      matchScore: 75,
      jobDescription: "Create beautiful and intuitive user interfaces for web applications.",
      requirements: {"3+ years frontend experience", "Design systems", "Cross-browser testing"},
      salaryRange: "$85,000 - $110,000"
    },
    {
      jobId: 5,
      jobName: "Data Engineer",
      department: "Data Science",
      location: "Seattle, WA",
      matchingSkills: {"Python", "SQL", "Apache Spark", "AWS", "Data Pipelines"},
      matchScore: 82,
      jobDescription: "Build and maintain data infrastructure for analytics and machine learning.",
      requirements: {"4+ years data experience", "Big data technologies", "ETL processes"},
      salaryRange: "$105,000 - $135,000"
    }
  },
  
  /* State management for user interactions */
  local!selectedJobIds: {},
  local!savedJobIds: {},
  
  a!sectionLayout(
    label: "Recommended Job Opportunities (" & length(local!recommendedJobs) & " matches found)",
    labelSize: "LARGE",
    contents: {
      a!stampField(
        labelPosition: "COLLAPSED",
        text: "Based on your resume analysis, here are the best job matches for your profile:",
        backgroundColor: "POSITIVE",
        contentColor: "STANDARD",
        size: "SMALL",
        align: "LEFT",
        marginBelow: "STANDARD"
      ),
      
      /* Job Recommendation Cards */
      a!forEach(
        items: local!recommendedJobs,
        expression: a!cardLayout(
          contents: {
            /* Header Section - Job Name and Match Score */
            a!columnsLayout(
              columns: {
                a!columnLayout(
                  contents: {
                    /* Job Name */
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
                          text: fv!item.salaryRange,
                          color: "SECONDARY",
                          size: "SMALL",
                          style: "STRONG"
                        )
                      }
                    )
                  },
                  width: "WIDE"
                ),
                a!columnLayout(
                  contents: {
                    /* Match Score Gauge */
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
                      size: "MEDIUM",
                      align: "CENTER"
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
              value: a!richTextItem(
                text: fv!item.jobDescription,
                size: "MEDIUM"
              )
            ),
            
            /* Matching Skills Section */
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
            
            /* Key Requirements */
            a!richTextDisplayField(
              label: "Key Requirements",
              labelPosition: "ABOVE",
              value: a!forEach(
                items: fv!item.requirements,
                expression: {
                  a!richTextItem(text: "• ", color: "ACCENT", style: "STRONG"),
                  a!richTextItem(text: fv!item),
                  char(10)
                }
              )
            ),
            
            /* Action Buttons */
            a!buttonArrayLayout(
              buttons: {
                a!buttonWidget(
                  label: if(
                    contains(fv!item.jobId, local!selectedJobIds),
                    "Applied ✓",
                    "Apply"
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
                  size: "STANDARD",
                  disabled: contains(fv!item.jobId, local!selectedJobIds),
                  saveInto: {
                    a!save(
                      local!selectedJobIds,
                      append(local!selectedJobIds, fv!item.jobId)
                    )
                    /* Add your application submission logic here */
                    /* Example: rule!JOB_SubmitApplication(jobId: fv!item.jobId) */
                  }
                ),
                a!buttonWidget(
                  label: "View Details",
                  icon: "eye",
                  style: "SECONDARY",
                  size: "STANDARD",
                  saveInto: {
                    /* Add your job details navigation logic here */
                    /* Example: a!startProcess() or navigation */
                  }
                ),
                a!buttonWidget(
                  label: if(
                    contains(fv!item.jobId, local!savedJobIds),
                    "Saved ★",
                    "Save Later"
                  ),
                  icon: if(
                    contains(fv!item.jobId, local!savedJobIds),
                    "star",
                    "bookmark"
                  ),
                  style: "SECONDARY",
                  size: "STANDARD",
                  saveInto: {
                    if(
                      contains(fv!item.jobId, local!savedJobIds),
                      /* Remove from saved */
                      a!save(
                        local!savedJobIds,
                        remove(local!savedJobIds, wherecontains(fv!item.jobId, local!savedJobIds))
                      ),
                      /* Add to saved */
                      a!save(
                        local!savedJobIds,
                        append(local!savedJobIds, fv!item.jobId)
                      )
                    )
                    /* Add your save job logic here */
                    /* Example: rule!JOB_SaveForLater(jobId: fv!item.jobId) */
                  }
                ),
                a!buttonWidget(
                  label: "Cancel",
                  icon: "times",
                  style: "OUTLINE",
                  size: "STANDARD",
                  saveInto: {
                    /* Remove this job from recommendations */
                    a!save(
                      local!recommendedJobs,
                      remove(
                        local!recommendedJobs,
                        wherecontains(fv!item.jobId, local!recommendedJobs.jobId)
                      )
                    )
                    /* Add your dismiss job logic here */
                    /* Example: rule!JOB_DismissRecommendation(jobId: fv!item.jobId) */
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
      ),
      
      /* Summary Section */
      if(
        length(local!selectedJobIds) > 0,
        a!stampField(
          labelPosition: "COLLAPSED",
          text: "✅ You have applied to " & length(local!selectedJobIds) & " position(s). HR will review your applications and contact you soon.",
          backgroundColor: "POSITIVE",
          contentColor: "STANDARD",
          size: "MEDIUM",
          align: "LEFT",
          marginAbove: "STANDARD"
        ),
        {}
      )
    },
    isCollapsible: false,
    showBorder: true
  )
)

# Appian AI Resume Job Matcher Interface

This repository contains the complete Appian SAIL interface implementation for an AI-powered resume analysis and job recommendation system.

## Overview

The AI Resume Job Matcher analyzes candidate resumes using Appian AI Skills and recommends suitable job openings within the organization. The interface displays AI-generated recommendations including job names, matching skills, match scores, and interactive action buttons.

## Files Included

### 1. Core Interface Files

- **`resume_job_matcher_interface.sail`** - Basic implementation with core functionality
- **`enhanced_job_matcher_interface.sail`** - Full-featured implementation with advanced capabilities

### 2. Supporting Rule Files

- **`ai_resume_analysis_rule.txt`** - Expression rule for AI integration
- **`job_application_process_rule.txt`** - Job application workflow management

## Key Features

### ✅ Resume Analysis
- File upload support (PDF, DOC, DOCX)
- Text input option for resume content
- AI-powered skill extraction and analysis
- Experience level assessment

### ✅ Job Recommendations
- Multiple job matches display
- Match score visualization (percentage gauges)
- Skill matching highlights
- Job details including:
  - Job title and department
  - Location and employment type
  - Salary range
  - Key requirements
  - Benefits and perks

### ✅ Interactive Actions
- **Apply Now** - Submit job application
- **View Details** - Open detailed job description
- **Save for Later** - Bookmark jobs
- **Cancel/Not Interested** - Remove from recommendations

### ✅ Advanced Features
- Filtering options (department, location, match score, remote jobs)
- Application tracking and status
- Resume enhancement suggestions
- Progress saving
- Batch application processing

### ✅ User Experience
- Step-by-step guided process
- Real-time loading indicators
- Success/error message handling
- Responsive card-based layout
- Visual skill tags and match scores

## AI Integration Points

### Required AI Skill Integration
Replace the sample data with actual AI Skill calls:

```sail
/* In ai_resume_analysis_rule.txt */
local!aiResponse: rule!CALL_AI_SKILL_ResumeAnalysis(
  skillId: cons!AI_SKILL_RESUME_ANALYZER,
  input: {
    resumeContent: ri!resumeText,
    candidateProfile: rule!GET_CandidateProfile(ri!candidateId),
    jobDatabase: rule!GET_ActiveJobPostings()
  }
)
```

### Expected AI Output Structure
```json
{
  "success": true,
  "recommendations": [
    {
      "jobId": 1,
      "jobTitle": "Senior Software Engineer",
      "department": "Engineering",
      "workLocation": "Remote",
      "skillsMatched": ["Java", "React", "AWS"],
      "compatibilityScore": 92,
      "roleDescription": "Lead development...",
      "keyRequirements": ["5+ years experience"],
      "compensationRange": "$120,000 - $150,000"
    }
  ],
  "candidateAnalysis": {
    "primarySkills": ["Java", "JavaScript", "AWS"],
    "experienceLevel": "Senior",
    "suggestions": ["Add cloud certifications"]
  }
}
```

## Implementation Steps

### 1. Setup Constants
Create required constants in Appian:
- `cons!AI_SKILL_RESUME_ANALYZER` - AI Skill identifier
- `cons!RESUME_UPLOAD_FOLDER` - File upload folder
- `cons!PM_JOB_DETAILS_VIEWER` - Job details process model

### 2. Database Integration
Implement supporting rules:
- `rule!GET_JobDetails()` - Fetch job information
- `rule!GET_CandidateProfile()` - Get candidate data
- `rule!CREATE_JobApplication()` - Store applications

### 3. AI Skill Configuration
- Configure the AI Skill for resume analysis
- Set up job database access for the AI
- Define skill matching algorithms

### 4. Workflow Integration
- Application review processes
- Email notifications
- Status tracking workflows

## Sample Usage Scenarios

### Scenario 1: Single Job Match
1. Candidate uploads resume
2. AI analyzes and finds 1 perfect match (95% score)
3. Candidate applies directly
4. Application submitted to HR workflow

### Scenario 2: Multiple Job Matches
1. Candidate pastes resume text
2. AI finds 5 suitable positions (75-92% match scores)
3. Candidate reviews all options
4. Applies to 3 positions
5. Saves 1 for later consideration

### Scenario 3: No Matches Found
1. Resume analysis completed
2. No jobs meet minimum threshold
3. Interface suggests resume improvements
4. Provides alternative resources

## Customization Options

### Visual Customization
- Modify color schemes in gauge fields
- Adjust card layouts and spacing
- Update icons and styling
- Customize success/error messages

### Functional Customization
- Adjust minimum match score thresholds
- Modify filter options
- Add additional job attributes
- Customize application workflows

### AI Model Tuning
- Adjust skill matching weights
- Modify experience level calculations
- Enhance recommendation algorithms
- Add industry-specific analysis

## Security Considerations

- Resume data encryption
- Access control for job information
- Audit logging for applications
- Privacy compliance (GDPR/CCPA)

## Performance Optimization

- AI Skill response caching
- Lazy loading for large job lists
- Efficient database queries
- Client-side filtering where possible

## Testing Scenarios

### Test Case 1: Complete Application Flow
1. Upload valid resume file
2. Verify AI analysis completes
3. Check job recommendations display
4. Submit application successfully
5. Confirm email notifications

### Test Case 2: Error Handling
1. Upload invalid file format
2. Submit empty resume
3. Apply to closed position
4. Handle AI service unavailability

### Test Case 3: Filtering and Search
1. Apply department filters
2. Set minimum match scores
3. Toggle remote-only option
4. Verify results update correctly

## Deployment Checklist

- [ ] AI Skill configured and tested
- [ ] Database tables created
- [ ] File upload permissions set
- [ ] Email templates configured
- [ ] Workflow processes deployed
- [ ] Security permissions assigned
- [ ] User acceptance testing completed
- [ ] Performance testing passed

## Support and Maintenance

### Monitoring
- AI Skill performance metrics
- Application success rates
- User engagement analytics
- Error rate tracking

### Regular Updates
- Job database synchronization
- AI model retraining
- Interface enhancements
- Security patches

## Troubleshooting

### Common Issues
1. **AI Analysis Fails** - Check AI Skill configuration and input format
2. **No Jobs Found** - Verify job database connectivity and data freshness
3. **Application Errors** - Check workflow permissions and database constraints
4. **File Upload Issues** - Verify folder permissions and file size limits

### Debug Mode
Enable detailed logging by setting debug flags in the expression rules for enhanced troubleshooting capabilities.

---

For technical support or feature requests, contact the development team or create an issue in the project repository.

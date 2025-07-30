# HR Dashboard - Appian 25.2 Implementation

## Overview
A modern, colorful HR Dashboard interface built using Appian 25.2 features, designed specifically for HR professionals to manage job roles, track vacancies, and access essential HR tools.

## Features

### 🎯 KPI Header Section
Four visually distinct KPI cards displaying:
- **Active Job Roles** (Green) - Total count of currently active positions
- **Inactive Job Roles** (Red) - Total count of inactive/closed positions  
- **Temporary Vacancies** (Orange) - Available temporary hire positions
- **Permanent Vacancies** (Blue) - Available permanent hire positions

Each KPI card includes:
- Large, colorful icons (briefcase, times-circle, clock, user-check)
- Bold numeric indicators in matching colors
- Clear descriptive labels
- Subtle shadows and decorative top bars
- Responsive design that stacks on mobile/tablet

### 📋 Job Listings Section (Left Column)
Interactive job cards displaying 6 sample positions with:
- **Job Title** - Prominent heading for each position
- **Vacancy Count** - Number of open positions
- **Applicant Count** - Current number of applicants
- **Status Tags** - Color-coded status indicators:
  - Green "Open" for standard positions
  - Red "Urgent" for high-priority roles
- **Apply Now Button** - Call-to-action for each position
- **Visual Indicators**:
  - Colored left border (green for open, red for urgent)
  - Icons for vacancies and applicants
  - Hover shadows and clean borders

### 🛠️ HR Tools Section (Right Column)
Three utility cards for HR workflows:

#### 1. Bulk Resume Upload (Green Background)
- Cloud upload icon
- Full-width "Upload Files" button
- Designed for processing multiple resumes

#### 2. Record Chatbot (Blue Background)  
- Microphone icon
- "Start Recording" button with play icon
- Voice-enabled HR assistant functionality

#### 3. Document Chatbot (Purple Background)
- Comments icon
- "Start Chat" button
- AI-powered document analysis tool

## Technical Implementation

### Appian 25.2 Features Used
- **`a!headerContentLayout`** - Modern header structure
- **`a!cardLayout`** - Card-based design with shadows and decorative bars
- **`a!columnsLayout`** - Responsive multi-column layouts
- **`a!richTextDisplayField`** - Rich text formatting with icons
- **`a!tagField`** - Status tags with color coding
- **`a!forEach`** - Dynamic content generation
- **Modern Styling**:
  - `showShadow: true` for depth
  - `decorativeBarPosition` and `decorativeBarColor` for visual hierarchy
  - `backgroundColor` for card theming
  - Responsive `stackWhen` breakpoints

### Color Scheme
- **Green (POSITIVE)** - Active roles, open positions, upload functionality
- **Red (NEGATIVE)** - Inactive roles, urgent positions
- **Orange (SECONDARY)** - Temporary positions, document tools
- **Blue (ACCENT)** - Permanent positions, recording tools, main branding

### Responsive Design
- Desktop: 4-column KPI grid, 2-column main layout
- Tablet/Mobile: Stacked single-column layout
- Optimized spacing and padding for all screen sizes

### Accessibility Features
- Descriptive `accessibilityText` for all cards
- High contrast color schemes
- Clear visual hierarchy
- Icon + text combinations for better comprehension

## Sample Data Structure

```javascript
local!jobListings: {
  {
    jobName: "Senior Software Engineer",
    vacancies: 3,
    applicants: 47,
    status: "Open",
    urgent: false
  },
  // ... additional job entries
}
```

## Customization Options

### Adding New KPIs
Extend the KPI section by adding new `a!columnLayout` blocks with:
- Custom icons and colors
- Dynamic data binding
- Consistent card styling

### Job Listing Modifications
Modify the `local!jobListings` array to include:
- Additional job properties
- Custom status types
- Department categorization
- Salary ranges

### Tool Card Extensions
Add new utility cards by following the established pattern:
- Descriptive icons
- Clear call-to-action buttons
- Themed background colors
- Consistent spacing

## Best Practices Applied

1. **Visual Hierarchy** - Clear information architecture with proper spacing
2. **Color Psychology** - Meaningful color associations (green=positive, red=urgent)
3. **Modern Aesthetics** - Clean cards with subtle shadows and borders
4. **Mobile-First** - Responsive design considerations
5. **Accessibility** - High contrast, clear labels, assistive text
6. **Scalability** - Modular structure for easy expansion

## Usage Instructions

1. Copy the code from `HR_Dashboard.sail` into your Appian interface
2. Replace sample data with actual data sources or rule inputs
3. Customize colors, icons, and labels to match your brand
4. Add click actions to buttons for full functionality
5. Test responsive behavior across different screen sizes

This dashboard provides a solid foundation for HR management interfaces while showcasing modern Appian 25.2 capabilities and design best practices.
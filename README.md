# Overtime App

## Key requirement: company needs documentation that salaried employees did not get overtime each week

## Models
-Post -> date:date rationale:text
-User -> Devise
-AdminUser -> STI ( Single Table Inheritance)  
 We will leverage AdminUser using User Table 

## Features:
- Approval Workflow
- SMS Sending -> link to approval or overtime input
- Administrate admin dashboard
- Email summary to manager for approval
- Needs to be documented if employee did not log overtime

## UI:
Bootstrap -> formatting

## Refactor TODOS:
- Refactor user association intergration test in post_spec

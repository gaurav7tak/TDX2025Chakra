# Project Chakra: AI-Powered Health Assistant (Salesforce/Agentforce)
 Welcome to Project Chakra, an AI-driven chatbot application designed to support expecting mothers throughout their pregnancy journey and initial postnatal period. Built entirely on the Salesforce Platform, leveraging Agentforce and Salesforce AI, this project demonstrates a sophisticated multi-agent system catering to various patient needs.

**Repository:** [https://github.com/gaurav7tak/TDX2025Chakra/](https://github.com/gaurav7tak/TDX2025Chakra/)

## Overview

Project Chakra provides a conversational interface (chatbot) for patients (expecting mothers). Behind the chatbot lies a multi-agent AI system orchestrated by a central AI Agent. This central agent intelligently routes tasks to specialized agents based on the context of the conversation.

## Key Features

1.  **Patient Interaction:** Patients interact via a user-friendly chatbot interface.
2.  **Multi-Agent AI Core:** A central AI agent manages and delegates tasks to specialized agents:
    * **Registration Agent:**
        * Handles initial patient onboarding (Name, Email, DOB, etc.).
        * Creates patient records in the Salesforce database.
        * Populates initial "Medical Records" based on provided history.
        * Registers the newborn ("Baby of <MotherName>") post-delivery.
    * **Scheduling and Reminder Agent:**
        * Calculates future medical schedules (tests, checkups, visits) based on details like the last menstrual period (LMP).
        * Stores these events in the "Medical Event" table, marking "Delivery" as a key milestone.
        * Sends automated reminders 5 days before scheduled appointments/events.
        * Creates postnatal schedules for the newborn (vaccinations, checkups) in the "Medical Event" table.
    * **Recommendation and Answering Agent:**
        * Answers patient queries using information from trusted sources (e.g., National Institutes of Health - NIH).
        * Provides personalized recommendations by referencing the patient's "Medical Records" and "Medical Events" data.
    * **Service Agent:**
        * Facilitates booking external services like ambulances or house help via API integrations with third-party providers.
3.  **Live Agent Handoff:** Seamlessly transfers the conversation to a human medical counsellor for live chat support when requested or necessary.
4.  **Data Management:** Utilizes Salesforce database objects (like custom objects potentially named `Medical_Record__c`, `Medical_Event__c`) to store and manage patient and scheduling information.
5.  **Personalization:** Leverages patient data to provide tailored schedules, reminders, and answers.

## Architecture & Technology Stack

* **Platform:** Salesforce Platform
* **AI Framework:** Salesforce AI, Agentforce
* **Core Logic:** Apex, Flows, Actions
* **Frontend (Chatbot Interface):** Salesforce Messaging, Communities, UI
* **Database:** Salesforce Objects(Person Account, Medical Events, Medical Records)

The system employs a multi-agent architecture where a primary AI agent interprets user intent and delegates tasks to the appropriate specialized agent (Registration, Scheduling, Q&A, Service) for execution. This ensures modularity and focused functionality for each component.

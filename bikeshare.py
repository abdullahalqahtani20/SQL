import time
import pandas as pd
import numpy as np

CITY_DATA = {
    'chicago': 'chicago.csv',
    'new york city': 'new_york_city.csv',
    'washington': 'washington.csv'
}

def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    print('Hello! Let\'s explore some US bikeshare data!')
    
    # Get user input for city
    while True:
        city = input("Would you like to see data for Chicago, New York City, or Washington?\n").lower()
        if city in CITY_DATA:
            break
        else:
            print("Invalid city. Please choose from Chicago, New York City, or Washington.")

    # Get user input for month and day
    while True:
        time_period = input("Would you like to filter by month, day, both, or not at all? Type 'none' for no time filter.\n").lower()
        if time_period == 'none':
            month = 'all'
            day = 'all'
            break
        elif time_period == 'month' or time_period == 'both':
            while True:
                month = input("Which month? January, February, March, April, May, or June?\n").lower()
                if month in ['january', 'february', 'march', 'april', 'may', 'june']:
                    break
                else:
                    print("Invalid month. Please choose a month from January to June.")
        else:
            month = 'all'
            
        if time_period == 'day' or time_period == 'both':
            while True:
                day = input("Which day? Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, or Sunday?\n").lower()
                if day in ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']:
                    break
                else:
                    print("Invalid day. Please enter a valid day of the week.")
        else:
            day = 'all'
            
        break  # Exit the loop after getting valid month and day

    print('-' * 40)
    return city, month, day


# ... (Rest of the functions remain the same)

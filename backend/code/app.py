from flask import Flask
from flask_restful import Api
from resources.customer import Customer, CustomerLogin, CustomerSignup, CustomerBookedEvents, CustomerAvailableEvents, CustomerList
from resources.restaurant import Restaurant, RestaurantLogin, RestaurantSignup, RestaurantEvents, RestaurantList
from resources.event import Event, AddEvent, RestaurantEventBookings, EventList
from resources.booking import Booking, AddBooking, BookingList
from db import db
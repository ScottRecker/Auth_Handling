from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from . import views

app_name = "api"
urlpatterns = [
    path("register/", views.RegisterAppUser.as_view(), name="registration"),
    path(
        "activate_account/<str:token>/",
        views.ActivateAccount.as_view(),
        name="user_activation",
    ),
    path("login_data/", views.LoginDataApi.as_view()),
    path("auth/token/", TokenObtainPairView.as_view()),
    path("auth/token/refresh/", TokenRefreshView.as_view()),
]

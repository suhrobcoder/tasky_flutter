import 'package:flutter/material.dart';
import 'package:tasky/auth/presentation/pages/onboarding_page.dart';
import 'package:tasky/auth/presentation/pages/password_reset_page.dart';
import 'package:tasky/auth/presentation/pages/signin_page.dart';
import 'package:tasky/auth/presentation/pages/register_page.dart';
import 'package:tasky/auth/presentation/pages/splash_page.dart';

var routes = {
  splashPage: (_) => const SplashPage(),
  onboardingPage: (_) => const OnboardingPage(),
  signInPage: (_) => const SignInPage(),
  forgotPasswordPage: (_) => const PasswordResetPage(),
  registerPage: (_) => const RegisterPage(),
  homePage: (_) => Text("Home"),
};

const splashPage = "splash";
const onboardingPage = "onboarding";
const signInPage = "sign_in";
const forgotPasswordPage = "forgot_password";
const registerPage = "register";
const homePage = "home";

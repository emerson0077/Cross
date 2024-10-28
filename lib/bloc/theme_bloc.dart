import 'package:flutter_bloc/flutter_bloc.dart';

// Define Theme Events
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

// Define Theme States
class ThemeState {
  final bool isDarkMode;

  ThemeState({required this.isDarkMode});
}

// Theme Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkMode: false)); // Initial state is light mode

  @override
  // ignore: override_on_non_overriding_member
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ToggleThemeEvent) {
      yield ThemeState(isDarkMode: !state.isDarkMode); // Toggle dark mode
    }
  }
}

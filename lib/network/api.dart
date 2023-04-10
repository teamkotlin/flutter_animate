class Apis{
  static const APP_BASE_URL = "https://achs.edu.pk/";
  static const BASE_URL = APP_BASE_URL+"api/";
  static const login = "user/login";
  static const teacherLectures = "teacher/get_teacher_lectures";
  static const starLecture = "attendance/startLecture";
  static const getStdForAttendance = "attendance/getStdForAttendance";
  static const submitAttendance = "attendance/submitAttendance";
  static const isAnyLectureStarted="attendance/isAnyLectureStarted";
}
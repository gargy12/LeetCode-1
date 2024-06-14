WITH
  Majors AS (
    SELECT major, COUNT(course_id) AS course_count
    FROM Courses
    GROUP BY 1
  ),
  StudentToGradeACourseCount AS (
    SELECT
      Students.student_id,
      Students.major,
      COUNT(Enrollments.course_id) AS course_count
    FROM Students
    INNER JOIN Courses
      USING (major)
    INNER JOIN Enrollments
      USING (student_id, course_id)
    WHERE Enrollments.grade = 'A'
    GROUP BY 1, 2
  )
SELECT student_id
FROM StudentToGradeACourseCount
INNER JOIN Majors
  USING (major, course_count)
ORDER BY 1;

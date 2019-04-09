class Student
  attr_reader :id, :name, :grade

  def self.create_table
    DB[:conn].execute("CREATE TABLE IF NOT EXISTS students ( id INTEGER PRIMARY KEY, name TEXT, grade TEXT);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students;")
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  def initialize(id=nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?);", @name, @grade)
    @id = DB[:conn].execute("SELECT id FROM students ORDER BY id DESC LIMIT 1;").flatten![0]
    self
  end

end

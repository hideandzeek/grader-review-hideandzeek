CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Clean up previous runs
rm -rf student-submission
rm -rf grading-area

# Create grading area directory
mkdir grading-area

# Clone student submission
git clone $1 student-submission
echo 'Finished cloning'

# Check if the necessary file is submitted
if [ ! -f student-submission/ListExamples.java ]; then
    echo "Missing necessary files"
    exit 1
fi

echo "File submission is correct"

# Move files to grading area
cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area
cd grading-area

# Compile student's code and grading tests
javac -cp $CPATH:. *.java
if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

# Run the tests and capture the output
java -cp $CPATH:. org.junit.runner.JUnitCore TestListExamples > test_output.txt
TEST_RESULT=$?

# Display test output
echo "Test Output:"
cat test_output.txt

# Provide grading message based on the test result
if [ $TEST_RESULT -eq 0 ]; then
    echo "Tests passed"
    # You can add more detailed grading logic here if needed
else
    echo "Tests failed"
    # You can provide more detailed feedback by examining the test_output.txt file
fi
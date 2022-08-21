============
Introduction
============

To start off on configuring an autograde assignment, you will need to create the actual
autograde test code. There is quite a bit of machinery in place in the admin IDEs on anubis
to make this process more streamline and easy.

We encourage all TAs that are using Anubis for autograding to take a few minutes to read
this documentation to get familiar with the tools available. We guarantee you it will
save you time later.


Getting an Admin IDE
====================

.. NOTE::
  Admin IDEs in anubis are a type of Anubis IDE that has extra tools and permissions to make
  autograding and other administrative items easier. When writing autograde tests, or doing
  the actual grading, we encourage you to use an admin IDE.


.. WARNING::
  To get an Admin IDE, you must be a TA or Professor in at least one class. If you have not been
  added as a TA/Professor in Anubis, reach out to Anubis support to get the permissions you need.

Once you have admin permission on a course, when you log in next there will be new menus available to you
on the website.

.. image:: _static/admin-menu.png

Most of these menus should be relatively self explanatory. In these menus, you will be able to
see information about the students in your class, any assignments and their configuration, any course settings,
any anubis ides associated with the class, and autograde results.

To get an admin IDE, you will want to go to the admin -> assignments page, then click on the ``Admin IDE`` button.
That will bring up a page that looks something like this

.. image:: _static/admin-ide-modal.png

On this page, you will see

::

    @register_build
    def build(build_result: BuildResult):
        stdout, retcode = exec_as_student('make xv6.img fs.img')

        build_result.stdout = stdout
        build_result.passed = retcode == 0

        if 'this is a bad thing' in stdout:
            raise Panic("This is a bad thing that just happened. "
                        "We need to stop this pipeline right here and now")


::

    @register_test('Long file test')
    @points_test(10)
    def test_1(test_result: TestResult):
        test_result.message = "Testing long lines\n"

        # Start xv6 and run command
        stdout_lines = xv6_run("echo 123", test_result)

        # Run echo 123 as student user and capture output lines
        expected_raw, _ = exec_as_student('echo 123')
        expected = expected_raw.strip().split('\n')

        # Attempt to detect crash
        if did_xv6_crash(stdout_lines, test_result):
            return

        # Test to see if the expected result was found
        verify_expected(stdout_lines, expected, test_result)
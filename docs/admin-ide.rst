=========
Admin IDE
=========

.. NOTE::
  Admin IDEs in anubis are a type of Anubis IDE that has extra tools and permissions to make
  autograding and other administrative items easier. When writing autograde tests, or doing
  the actual grading, we encourage you to use an admin IDE.


Getting an Admin IDE
====================

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

On this page, you will see that there are many settings. These are some of the internal settings of the Anubis IDE.
These settings are never exposed to students. We have found that on occasions TAs need to play with these
settings to test out various things.

Do not worry, the default settings on this page are almost certainly the settings that you need. As a rule, if
you do not know what the setting is for or what it does, you should not edit it.

From here, go ahead and click go. Once the IDE is ready, you can access it the same way as any other Anubis IDE.


Whats in an Admin IDE?
======================

The Anubis Admin IDEs have quite a few extra things that would normally never be used by students. From a architecture
design standpoint, they have a lot more permissions and are treated very differently from the normal student IDEs.

Anubis CLI in Admin IDE
-----------------------

When you use the Anubis CLI in an IDE, it is automatically configured to be authenticated as you. We do this so
that users can do actions within Anubis from an IDE in a seamless way.

To test this out, launch an Admin IDE and run

::

  anubis whoami

Assuming all if configured right, you will see some output that says that your IDE is authenticated as you.

From an administration standpoint, this is the intended way for a lot of management actions to take place.
The CLI is configured for you as a TA to be able to create assignments, adjust (some of the) settings of assignment,
clone student repos for an assignment, and to test student code to name a few. All of said management actions can
only be preformed in an Anubis Admin IDE.

.. NOTE::
   Normal IDEs are simply not initialized in such a way to have permissions to do any of these actions.

To see more, check the page on the Anubis CLI

Docker
------

Yeah you read that right. Docker runs in the Admin IDEs. Pretty cool right? Docker running in a Cloud IDE server.

Docker is included in the IDE because the assignment test code is packaged and deployed as docker containers.

.. WARNING::
  In any Anubis IDE, the home directory ``/home/anubis`` is automatically persisted between sessions (ie. you can delete
  and recreate the IDE and your files will still be there). One thing to note is that this is not the case for
  docker. Any images or containers that you have in docker will be lost when the IDE is deleted. Make sure to push
  anything to the registry!


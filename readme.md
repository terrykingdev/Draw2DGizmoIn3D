# Godot - Draw 2D Gizmo in 3D

I couldn't find many details about drawing in the 3D viewport for creating debug gizmo which are visible at runtime. I found a solution using meshes, which seems to be the only way to go if you're using 3D. But by using a 2D node you can easily override the _draw to draw what you want. The only thing to figure out is how to get the screen coordinate from the 3D. This is done with unproject_position which is a method of a camera.

However... There were some strange issues which I hope someone can shed some light on. Firstly the aspect ratio isn't square, it seems to follow the 4:3 ratio which resulted in the circle coming out as an ellipse. So it actually draws an ellipse now and stretches it horizontally.

The second weirder issue is to get the lines matching accurately I had to use some fudge values which I matched by trial and error. These are the xFudge (4.52) and yFudge (4.77). If changed most of the viewport settings and it didn't seem to have any effect so I can't see where the values are coming from.

Another issue which would be a nice to fix rather than essential is when a point is behind the camera is reverses and gets drawn going into the screen. So fixes welcome :)

![2DGizmo](./images/2DGizmo.png)

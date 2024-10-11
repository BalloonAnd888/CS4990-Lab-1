// Useful to sort lists by a custom key
import java.util.Comparator;


/// In this file you will implement your navmesh and pathfinding.

/// This node representation is just a suggestion
class Node
{
  int id;
  ArrayList<Wall> polygon;
  PVector center;
  ArrayList<Node> neighbors;
  ArrayList<Wall> connections;
}



class NavMesh
{
  ArrayList<Node> nodes;
  ArrayList<PVector> reflex;

  NavMesh() {
    nodes = new ArrayList<>();
    reflex = new ArrayList<>();
  }

  void bake(Map map)
  {
    /// generate the graph you need for pathfinding

    // Identify corners of the walkable area (defined as polygon outline)
    ArrayList<Wall> corners = new ArrayList<>(map.outline);
    System.out.println("Vertices");
    for (Wall wall : corners) {
      PVector start = wall.start;
      PVector end = wall.end;

      System.out.println("Start: " + start.x + ", " + start.y);
      System.out.println("End: " + end.x + ", " + end.y);
      //System.out.println("Direction: " + wall.direction);
      //System.out.println("Normal: " + wall.normal);

      //System.out.println("Start: " + wall.start.x + ", " + wall.start.y);
      //System.out.println("End: " + wall.end.x + ", " + wall.end.y);
    }

    // Map 1
    //Vertices
    //Start: 0.0, 600.0
    //End: 640.0, 600.0
    //Direction: [ 1.0, 0.0, 0.0 ]
    //Normal: [ -0.0, 1.0, 0.0 ]
    //Start: 640.0, 600.0
    //End: 440.0, 420.0
    //Direction: [ -0.7432942, -0.66896474, 0.0 ]
    //Normal: [ 0.66896474, -0.7432942, 0.0 ]
    //Start: 440.0, 420.0
    //End: 600.0, 60.0
    //Direction: [ 0.40613845, -0.91381156, 0.0 ]
    //Normal: [ 0.91381156, 0.40613845, 0.0 ]
    //Start: 600.0, 60.0
    //End: 800.0, 540.0
    //Direction: [ 0.3846154, 0.9230769, 0.0 ]
    //Normal: [ -0.9230769, 0.3846154, 0.0 ]
    //Start: 800.0, 540.0
    //End: 800.0, 0.0
    //Direction: [ 0.0, -1.0, 0.0 ]
    //Normal: [ 1.0, 0.0, 0.0 ]
    //Start: 800.0, 0.0
    //End: 200.0, 0.0
    //Direction: [ -1.0, 0.0, 0.0 ]
    //Normal: [ -0.0, -1.0, 0.0 ]
    //Start: 200.0, 0.0
    //End: 200.0, 90.0
    //Direction: [ 0.0, 1.0, 0.0 ]
    //Normal: [ -1.0, 0.0, 0.0 ]
    //Start: 200.0, 90.0
    //End: 0.0, 90.0
    //Direction: [ -1.0, 0.0, 0.0 ]
    //Normal: [ -0.0, -1.0, 0.0 ]
    //Start: 0.0, 90.0
    //End: 0.0, 600.0
    //Direction: [ 0.0, 1.0, 0.0 ]
    //Normal: [ -1.0, 0.0, 0.0 ]

    // Determine which corners are non-convex (concave) by checking if the angle is > 180
    // a.normal.dot(b.direction)
    //ArrayList<PVector> reflex = new ArrayList<>();
    for (int i = 0; i < corners.size(); i++) {
      Wall current = corners.get(i);
      Wall next = corners.get((i + 1) % corners.size());
      Wall previous = corners.get((i - 1 + corners.size()) % corners.size());

      float dotProduct = previous.normal.dot(current.direction);
      //System.out.println("Dot Product: " + dotProduct);

      if (dotProduct > 0) {
        reflex.add(current.start);
        //System.out.println("Reflex Angle Found");
      }
    }

    System.out.println("Reflex Angles");
    for (int i = 0; i < reflex.size(); i ++) {
      System.out.println(reflex.get(i));
    }

    // For each non-convex corner, add edges to split polygon into convex polygons,
    // find corner to add edge and check the new polygon to see if there's a reflex angle






    // Draw a line that splits the polygon into two parts
    // Repeate until all polygons are convex
    // Create a graph where each node represents a convex polygon
    // Two nodes are connected by an edge if the polygons share a border (common edge)
    // Find midpoint of shared edges
    // If obstacles are present, extend outline of map by connecting the obstacle vertices to the outer edges of the map





    //for (Wall wall : map.outline) {
    //  Node node = new Node();
    //  node.polygon = new ArrayList<>(map.outline);

    //  nodes.add(node);
    //}
  }

  ArrayList<PVector> findPath(PVector start, PVector destination)
  {
    /// implement A* to find a path
    ArrayList<PVector> result = null;
    return result;
  }


  void update(float dt)
  {
    draw();
  }

  void draw()
  {
    /// use this to draw the nav mesh graph
    stroke(255);
    for (Node node : nodes) {
      for (Wall wall : node.polygon) {
        line(wall.start.x, wall.start.y, wall.end.x, wall.end.y);
      }
    }
    
    fill(255, 0, 0);
    for (PVector reflex : reflex) {
      ellipse(reflex.x, reflex.y, 12, 12);
    }
  }
}

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
    }

    // Split the polygon until all polygons are convex
    ArrayList<ArrayList<Wall>> polygons = splitIntoConvexPolygons(corners);

    //findReflexAngles(corners);
    //System.out.println(isConvexPolygon(corners));

    for (ArrayList<Wall> polygon : polygons) {
      Node node = new Node();
      node.polygon = polygon;
      //node.center = calculateCentroid(polygon);
      node.neighbors = new ArrayList<>();
      nodes.add(node);
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

  ArrayList<ArrayList<Wall>> splitIntoConvexPolygons(ArrayList<Wall> corners) {
    ArrayList<ArrayList<Wall>> polygons = new ArrayList<>();
    ArrayList<Wall> current = new ArrayList<>(corners);

    //  // Loop until all polygons are convex
    //while (!isConvexPolygon(current)) {
    //  // Find all reflex angles
    //  ArrayList<PVector> reflexCorners = findReflexAngles(current);

    //  if (reflexCorners.isEmpty()) {
    //    polygons.add(current);
    //  }

    //  // For each reflex angles, create edge
    //  for (PVector reflexCorner : reflexCorners) {
    //    System.out.println(reflexCorner);
    //    Wall edge = createEdge(reflexCorner, current, map);
    //    System.out.println(edge);
    //    //System.out.println(edge.start);
    //    //System.out.println(edge.end);
    //    if (edge != null) {
    //      ArrayList<Wall> newPolygon = splitPolygon(current, edge);
    //      polygons.add(newPolygon);
    //      //current = removeWalls(current, newPolygon);
    //      //current.remove(newPolygon);
    //      for (Wall wall : newPolygon) {
    //        current.remove(wall);
    //      }
    //    }
    //  }
    //}
    //if (!current.isEmpty()) {
    //  polygons.add(current);
    //}


    // Find all reflex angles
    ArrayList<PVector> reflexCorners = findReflexAngles(current);

    if (reflexCorners.isEmpty()) {
      polygons.add(current);
    }
    for (PVector reflexCorner : reflexCorners) {
      System.out.println(reflexCorner);
      Wall edge = createEdge(reflexCorner, current, map);
      System.out.println(edge);
      //System.out.println(edge.start);
      //System.out.println(edge.end);
      if (edge != null) {
        ArrayList<Wall> newPolygon = splitPolygon(current, edge);
        polygons.add(newPolygon);
        //for (Wall wall : newPolygon) {
        //  current.remove(wall);
        //}
      }
    }
    if (!current.isEmpty()) {
      polygons.add(current);
    }


    // Split polygon with the edge
    // Remove edge from the remaining polygon
    // Recheck for reflex vertex in updated remaining polygon

    //findReflexAngles(corners);
    //System.out.println(isConvexPolygon(corners));


    return polygons;
  }

  ArrayList<Wall> splitPolygon(ArrayList<Wall> polygon, Wall edge) {
    ArrayList<Wall> newPolygon = new ArrayList<>();

    // The start and end of the splitting edge
    PVector start = edge.start;
    PVector end = edge.end;

    // Find the indices of the walls that match the edge's start and end
    int splitStartIndex = -1;
    int splitEndIndex = -1;

    for (int i = 0; i < polygon.size(); i++) {
      Wall wall = polygon.get(i);

      // Check if the start of the wall matches the edge start
      if (wall.start.equals(start)) {
        splitStartIndex = i;
      }

      // Check if the start of the wall matches the edge end
      if (wall.start.equals(end)) {
        splitEndIndex = i;
      }
    }

    if (splitStartIndex == -1 || splitEndIndex == -1) {
      throw new IllegalStateException("Cannot find points in polygon to split.");
    }

    // Create the first half of the polygon
    for (int i = splitStartIndex; i != splitEndIndex; i = (i + 1) % polygon.size()) {
      newPolygon.add(polygon.get(i));
    }

    // Add the edge to the new polygon
    newPolygon.add(edge);

    // Optionally, you can return the remaining polygon as well
    return newPolygon;
  }


  ArrayList<Wall> removeWalls(ArrayList<Wall> original, ArrayList<Wall> toRemove) {
    ArrayList<Wall> remaining = new ArrayList<>(original);
    for (Wall wall : toRemove) {
      remaining.remove(wall); // Remove the walls of the new polygon from the current
    }
    return remaining;
  }

  Wall createEdge(PVector reflex, ArrayList<Wall> polygon, Map map) {
    for (Wall wall : polygon) {
      PVector candidate = wall.start;
      System.out.println(candidate);
      //System.out.println(!intersects(reflex, candidate, wall.start, wall.end));
      //System.out.println(reflex.equals(candidate));
      // Check if the edge collides with a wall
      if (!reflex.equals(candidate) && !intersects(reflex, candidate, wall.start, wall.end)) {
        System.out.println("New Wall");
        return new Wall(reflex, candidate);  // Create the edge
      }
      //if (!reflex.equals(candidate) && wall.crosses(candidate, reflex)) {
      //  System.out.println("New Wall");
      //  return new Wall(reflex, candidate);  // Create the edge
      //}
    }
    return null;  // No valid edge found
  }

  boolean intersects(PVector p1, PVector p2, PVector p3, PVector p4) {
    PVector d1 = PVector.sub(p2, p1).normalize();
    PVector d2 = PVector.sub(p4, p3).normalize();

    float dist1 = d1.dot(PVector.sub(p3, p1).normalize());
    float dist2 = d1.dot(PVector.sub(p4, p1).normalize());
    float dist3 = d2.dot(PVector.sub(p1, p3).normalize());
    float dist4 = d2.dot(PVector.sub(p2, p3).normalize());

    // Check if the segments (p1-p2) and (p3-p4) intersect
    return (dist1 * dist2 < 0 && dist3 * dist4 < 0);
  }

  boolean isConvexPolygon(ArrayList<Wall> corners) {
    for (int i = 0; i < corners.size(); i++) {
      Wall current = corners.get(i);
      Wall next = corners.get((i + 1) % corners.size());
      Wall previous = corners.get((i - 1 + corners.size()) % corners.size());

      if (isReflex(current, next, previous)) {
        return false;
      }
    }

    return true;
  }

  ArrayList<PVector> findReflexAngles(ArrayList<Wall> corners) {
    // Determine which corners are non-convex (concave) by checking if the angle is > 180
    // a.normal.dot(b.direction)
    //ArrayList<PVector> reflex = new ArrayList<>();
    for (int i = 0; i < corners.size(); i++) {
      Wall current = corners.get(i);
      Wall next = corners.get((i + 1) % corners.size());
      Wall previous = corners.get((i - 1 + corners.size()) % corners.size());

      if (isReflex(current, next, previous)) {
        reflex.add(current.start);
        System.out.println("Reflex Angle Found");
      }
    }

    return reflex;
  }

  boolean isReflex(Wall current, Wall next, Wall previous) {

    float dotProduct = previous.normal.dot(current.direction);

    if (dotProduct > 0) {
      return true;
    }

    return false;
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

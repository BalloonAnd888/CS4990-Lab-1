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
  int currentIndex = -1;

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
  }

  ArrayList<ArrayList<Wall>> splitIntoConvexPolygons(ArrayList<Wall> corners) {
    ArrayList<ArrayList<Wall>> polygons = new ArrayList<>();
    ArrayList<Wall> current = new ArrayList<>(corners);

    // Loop until all polygons are convex
    while (!isConvexPolygon(current)) {
      // Find all reflex angles
      ArrayList<PVector> reflexCorners = findReflexAngles(current);

      if (reflexCorners.isEmpty()) {
        polygons.add(current);
        break;
      }
      int currentIndex = -1;
      for (PVector reflexCorner : reflexCorners) {
        System.out.println("Reflex Corner: " + reflexCorner);
        Wall edge = createEdge(reflexCorner, current, map);
        //System.out.println(edge);
        System.out.println("Edge:");
        System.out.println("Start: " + edge.start);
        System.out.println("End: " + edge.end);
        if (edge != null) {
          ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);
          System.out.print("New Polygon\n");
          for (Wall wall : newPolygon) {
            System.out.print("Side\n");
            System.out.println("Start: " + wall.start);
            System.out.println("End: " + wall.end);
          }
          
          //if (isConvexPolygon(newPolygon)) {
          //  polygons.add(newPolygon);
          //} else {
          // polygons.addAll(splitIntoConvexPolygons(newPolygon)); 
          //}
          
          polygons.add(newPolygon);
          boolean gotIndex = false;
          for (Wall wall : newPolygon) {
            if (!wall.equals(edge)) {
              if (!gotIndex) {
                currentIndex = current.indexOf(wall);
                System.out.println("Index: " + currentIndex);
                current.remove(wall);
                gotIndex = true;
              } else {
                current.remove(wall);
              }
            }
          }
          current.add(currentIndex, new Wall(edge.end, edge.start));
          System.out.println("\nCurrent Map");
          for (Wall wall : current) {
            System.out.println("Side");
            System.out.println(wall.start);
            System.out.println(wall.end + "\n");
          }
        }
      }
    }
    if (!current.isEmpty()) {
      polygons.add(current);
    }



    //// Find all reflex angles
    //ArrayList<PVector> reflexCorners = findReflexAngles(current);

    //if (reflexCorners.isEmpty()) {
    //  polygons.add(current);
    //}
    //int currentIndex = -1;
    //for (PVector reflexCorner : reflexCorners) {
    //  System.out.println("Reflex Corner: " + reflexCorner);
    //  Wall edge = createEdge(reflexCorner, current, map);
    //  //System.out.println(edge);
    //  System.out.println("Edge:");
    //  System.out.println("Start: " + edge.start);
    //  System.out.println("End: " + edge.end);
    //  if (edge != null) {
    //    ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);
    //    System.out.print("New Polygon\n");
    //    for (Wall wall : newPolygon) {
    //      System.out.print("Side\n");
    //      System.out.println("Start: " + wall.start);
    //      System.out.println("End: " + wall.end);
    //    }
    //    polygons.add(newPolygon);
    //    boolean gotIndex = false;
    //    for (Wall wall : newPolygon) {
    //      if (!wall.equals(edge)) {
    //        if (!gotIndex) {
    //          currentIndex = current.indexOf(wall);
    //          System.out.println("Index: " + currentIndex);
    //          current.remove(wall);
    //          gotIndex = true;
    //        } else {
    //          current.remove(wall);
    //        }
    //      }
    //    }
    //    current.add(currentIndex, new Wall(edge.end, edge.start));
    //    System.out.println("\nCurrent Map");
    //    for (Wall wall : current) {
    //      System.out.println("Side");
    //      System.out.println(wall.start);
    //      System.out.println(wall.end + "\n");
    //    }
    //  }
    //}


    //ArrayList<PVector> reflexCorners = findReflexAngles(current);

    //if (!reflexCorners.isEmpty()) {
    //  PVector reflexCorner = reflexCorners.get(0);  // Get the first element
    //  System.out.println("First Reflex Corner: " + reflexCorner);

    //  Wall edge = createEdge(reflexCorner, current, map);

    //  if (edge != null) {
    //    System.out.println("Edge:");
    //    System.out.println("Start: " + edge.start);
    //    System.out.println("End: " + edge.end);

    //    ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);

    //    System.out.println("New Polygon:");
    //    for (Wall wall : newPolygon) {
    //      System.out.println("Side:");
    //      System.out.println("Start: " + wall.start);
    //      System.out.println("End: " + wall.end);
    //    }

    //    polygons.add(newPolygon);

    //    // Remove walls from the current polygon, excluding the edge used for splitting
    //    for (Wall wall : newPolygon) {
    //      if (!wall.equals(edge)) {
    //        current.remove(wall);
    //        //current.add(edge);
    //        //current.add(new Wall(edge.end, edge.start));
    //      }
    //    }
    //    current.add(new Wall(edge.end, edge.start));
    //  } else {
    //    System.out.println("Failed to create an edge from the reflex corner.");
    //  }
    //} else {
    //  System.out.println("No reflex corners found.");
    //}


    for (ArrayList<Wall> polygon : polygons) {
      System.out.println("\nConvex Polygon");
      for (Wall wall : polygon) {
        System.out.println("Side");
        System.out.println(wall.start);
        System.out.println(wall.end + "\n");
      }
    }

    //System.out.println("\nCurrent Map");
    //for (Wall wall : current) {
    //  System.out.println("Side");
    //  System.out.println(wall.start);
    //  System.out.println(wall.end + "\n");
    //}

    //findReflexAngles(corners);
    //System.out.println(isConvexPolygon(corners));

    return polygons;
  }

  ArrayList<Wall> splitPolygon(ArrayList<Wall> polygon, PVector reflexCorner, Wall edge) {
    ArrayList<Wall> newPolygon = new ArrayList<>();
    // add edge
    // check if wall.start == edge.start or edge.end
    // start from start of polygon and loop until reflexCorner
    //
    // start from reflexCorner
    // add edge
    // loop from start of polygon to reflexCorner or edge

    // add wall in between edge start and edge end
    // wall start == edge start or edge end

    // index of start of polygon to index of reflexCorner
    // (wall.start.equals(edge.start) || wall.start.equals(edge.end))
    // edge.end == wall.start || wall.start == edge.start
    //current.add(new Wall(edge.end, edge.start));

    boolean split = false;

    for (Wall wall : polygon) {
      if (wall.start.equals(edge.start) || wall.start.equals(edge.end)) {
        split = true;
      }

      if (split) {
        newPolygon.add(wall);
        if (wall.end.equals(edge.start) || wall.end.equals(edge.end)) {
          newPolygon.add(edge);
          break;
        }
      }
    }

    return newPolygon;
  }

  Wall createEdge(PVector reflex, ArrayList<Wall> polygon, Map map) {
    Wall edge = null;
    float distance = Float.MAX_VALUE;

    for (Wall wall : polygon) {
      PVector candidate = wall.start;
      System.out.println("Candidate: " + candidate);
      //System.out.println(!intersects(reflex, candidate, wall.start, wall.end));
      //System.out.println(reflex.equals(candidate));

      // Check if the edge collides with a wall
      if (!reflex.equals(candidate) &&
        !intersects(reflex, candidate, wall.start, wall.end) &&
        distance > PVector.dist(reflex, candidate) &&
        !isOriginalWall(reflex, candidate, polygon) &&
        //isPointInPolygon(getRandomPoint(new Wall(reflex, candidate)), polygon)
        isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon)
        ) {
        System.out.println("New Wall");
        distance = PVector.dist(reflex, candidate);
        edge = new Wall(reflex, candidate);
        //return new Wall(reflex, candidate);  // Create the edge
      }
      //if (!reflex.equals(candidate) && wall.crosses(candidate, reflex)) {
      //  System.out.println("New Wall");
      //  return new Wall(reflex, candidate);  // Create the edge
      //}
    }
    if (edge != null) {
      System.out.println("Shortest Edge: " + distance);
    }
    return edge;
    //return null;  // No valid edge found
  }

  boolean isOriginalWall(PVector reflex, PVector candidate, ArrayList<Wall> polygon) {
    for (Wall wall : polygon) {
      // Check if either (reflex, candidate) or (candidate, reflex) matches an existing wall
      if ((wall.start.equals(reflex) && wall.end.equals(candidate)) ||
        (wall.start.equals(candidate) && wall.end.equals(reflex))) {
        return true;
      }
    }
    return false;
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

// Useful to sort lists by a custom key
import java.util.Comparator;
import java.util.Stack;

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
      System.out.println("Direction: " + wall.direction);
    }
<<<<<<< Updated upstream
=======

    //Get reflex angles
    reflexAngles = findReflexAngles(corners, reflexAngles);
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
  ArrayList<ArrayList<Wall>> splitIntoConvexPolygons(ArrayList<Wall> corners) {
    ArrayList<ArrayList<Wall>> polygons = new ArrayList<>();
    Stack<ArrayList<Wall>> stack = new Stack<>();

    // Initialize the stack with the original polygon
    stack.push(new ArrayList<>(corners));

    while (!stack.isEmpty()) {
      ArrayList<Wall> current = stack.pop();
      ArrayList<PVector> reflexCorners = new ArrayList<>();

      //System.out.println("\nCurrent Map");
      //for (Wall wall : current) {
      //  System.out.println("Side");
      //  System.out.println(wall.start);
      //  System.out.println(wall.end + "\n");
      //}

      // Find all reflex angles
      reflexCorners = findReflexAngles(current);

      for (PVector rc : reflexCorners) {
        System.out.println("RC: " + rc);
      }

      for (PVector reflexCorner : reflexCorners) {
        Wall edge = createEdge(reflexCorner, current, map);
        //System.out.println(edge);
        //System.out.println("Edge:");
        //System.out.println("Start: " + edge.start);
        //System.out.println("End: " + edge.end);
        if (edge != null) {
          ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);
          //System.out.print("New Polygon\n");
          //for (Wall wall : newPolygon) {
          //  System.out.print("Side\n");
          //  System.out.println("Start: " + wall.start);
          //  System.out.println("End: " + wall.end);
          //}

          if (!newPolygon.isEmpty()) {
            if (isConvexPolygon(newPolygon)) {
              polygons.add(newPolygon);
            } else {
              stack.push(newPolygon); // Add the new polygon for further processing
              //System.out.println("\nStack");
              //for (ArrayList<Wall> s : stack) {
              //  System.out.println("\nStack Polygon");
              //  for (Wall wall : s) {
              //    System.out.println("Side");
              //    System.out.println(wall.start);
              //    System.out.println(wall.end + "\n");
              //  }
              //}
            }
          }

          System.out.println(isConvexPolygon(newPolygon));

          updateCurrent(current, newPolygon, edge);

          if (isConvexPolygon(current)) {
            polygons.add(current);
          } else {
            stack.push(current);
          }

          System.out.println("\nCurrent Map");
          for (Wall wall : current) {
            System.out.println("Side");
            System.out.println(wall.start);
            System.out.println(wall.end + "\n");
          }
        }
      }
    }

    System.out.println("\nList of Convex Polygons");
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

    return polygons;
  }

=======
>>>>>>> Stashed changes
  //ArrayList<ArrayList<Wall>> splitIntoConvexPolygons(ArrayList<Wall> corners) {
  //  ArrayList<ArrayList<Wall>> polygons = new ArrayList<>();
  //  Stack<ArrayList<Wall>> stack = new Stack<>();

  //  // Initialize the stack with the original polygon
  //  stack.push(new ArrayList<>(corners));

  //  while (!stack.isEmpty()) {
  //    ArrayList<Wall> current = stack.pop();
  //    ArrayList<PVector> reflexCorners = new ArrayList<>();

  //    //System.out.println("\nCurrent Map");
  //    //for (Wall wall : current) {
  //    //  System.out.println("Side");
  //    //  System.out.println(wall.start);
  //    //  System.out.println(wall.end + "\n");
  //    //}

  //    // Find all reflex angles
  //    reflexCorners = findReflexAngles(current, reflexAngles);

<<<<<<< Updated upstream
  //  // Find all reflex angles
  //  reflexCorners = findReflexAngles(current);

  //  //for (PVector rc : reflexCorners) {
  //  //  System.out.println("RC: " + rc);
  //  //}

  //  PVector reflexCorner = new PVector();
  //  //if (!reflexCorners.isEmpty()) {
  //  //  reflexCorner = reflexCorners.get(0);
  //  //  System.out.println("First Reflex Corner: " + reflexCorner);
  //  //} else {
  //  //  System.out.println("No reflex corners found.");
  //  //}

  //  //System.out.println("First Reflex Corner: " + reflexCorner);

  //  //for (PVector reflexCorner : reflexCorners) {
  //  Wall edge = createEdge(reflexCorner, current, map);
  //  //System.out.println(edge);
  //  //System.out.println("Edge:");
  //  //System.out.println("Start: " + edge.start);
  //  //System.out.println("End: " + edge.end);
  //  if (edge != null) {
  //    ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);
  //    //System.out.print("New Polygon\n");
  //    //for (Wall wall : newPolygon) {
  //    //  System.out.print("Side\n");
  //    //  System.out.println("Start: " + wall.start);
  //    //  System.out.println("End: " + wall.end);
  //    //}

  //    if (!newPolygon.isEmpty()) {
  //      if (isConvexPolygon(newPolygon)) {
  //        polygons.add(newPolygon);
  //      } else {
  //        stack.push(newPolygon); // Add the new polygon for further processing
  //        //System.out.println("\nStack");
  //        //for (ArrayList<Wall> s : stack) {
  //        //  System.out.println("\nStack Polygon");
  //        //  for (Wall wall : s) {
  //        //    System.out.println("Side");
  //        //    System.out.println(wall.start);
  //        //    System.out.println(wall.end + "\n");
  //        //  }
  //        //}
=======
  //    for (PVector rc : reflexCorners) {
  //      System.out.println("RC: " + rc);
  //    }

  //    for (PVector reflexCorner : reflexCorners) {
  //      Wall edge = createEdge(reflexCorner, current, map);
  //      //System.out.println(edge);
  //      //System.out.println("Edge:");
  //      //System.out.println("Start: " + edge.start);
  //      //System.out.println("End: " + edge.end);
  //      if (edge != null) {
  //        ArrayList<Wall> newPolygon = splitPolygon(current, reflexCorner, edge);
  //        //System.out.print("New Polygon\n");
  //        //for (Wall wall : newPolygon) {
  //        //  System.out.print("Side\n");
  //        //  System.out.println("Start: " + wall.start);
  //        //  System.out.println("End: " + wall.end);
  //        //}

  //        if (!newPolygon.isEmpty()) {
  //          if (isConvexPolygon(newPolygon)) {
  //            polygons.add(newPolygon);
  //          } else {
  //            stack.push(newPolygon); // Add the new polygon for further processing
  //            //System.out.println("\nStack");
  //            //for (ArrayList<Wall> s : stack) {
  //            //  System.out.println("\nStack Polygon");
  //            //  for (Wall wall : s) {
  //            //    System.out.println("Side");
  //            //    System.out.println(wall.start);
  //            //    System.out.println(wall.end + "\n");
  //            //  }
  //            //}
  //          }
  //        }

  //        System.out.println(isConvexPolygon(newPolygon));

  //        updateCurrent(current, newPolygon, edge);

  //        if (isConvexPolygon(current)) {
  //          polygons.add(current);
  //        } else {
  //          stack.push(current);
  //        }

  //        System.out.println("\nCurrent Map");
  //        for (Wall wall : current) {
  //          System.out.println("Side");
  //          System.out.println(wall.start);
  //          System.out.println(wall.end + "\n");
  //        }
>>>>>>> Stashed changes
  //      }
  //    }

  //    System.out.println(isConvexPolygon(newPolygon));

  //    updateCurrent(current, newPolygon, edge);

  //    if (isConvexPolygon(current)) {
  //      polygons.add(current);
  //    } else {
  //      stack.push(current);
  //    }

  //    //System.out.println("\nCurrent Map");
  //    //for (Wall wall : current) {
  //    //  System.out.println("Side");
  //    //  System.out.println(wall.start);
  //    //  System.out.println(wall.end + "\n");
  //    //}
  //  }
  //  //}

  //  System.out.println("\nList of Convex Polygons");
  //  for (ArrayList<Wall> polygon : polygons) {
  //    System.out.println("\nConvex Polygon");
  //    for (Wall wall : polygon) {
  //      System.out.println("Side");
  //      System.out.println(wall.start);
  //      System.out.println(wall.end + "\n");
  //    }
  //  }

  //  System.out.println("\nCurrent Map");
  //  for (Wall wall : current) {
  //    System.out.println("Side");
  //    System.out.println(wall.start);
  //    System.out.println(wall.end + "\n");
  //  }

  //  return polygons;
  //}


<<<<<<< Updated upstream
=======
  ArrayList<ArrayList<Wall>> splitIntoConvexPolygons(ArrayList<Wall> corners) {
    ArrayList<ArrayList<Wall>> polygons = new ArrayList<>();
    Stack<ArrayList<Wall>> stack = new Stack<>();

    // Initialize the stack with the original polygon
    stack.push(new ArrayList<>(corners));


    ArrayList<Wall> current = stack.pop();
    ArrayList<PVector> reflexCorners = new ArrayList<>();

    //System.out.println("\nCurrent Map");
    //for (Wall wall : current) {
    //  System.out.println("Side");
    //  System.out.println(wall.start);
    //  System.out.println(wall.end + "\n");
    //}

    // Find all reflex angles
    reflexCorners = findReflexAngles(current, reflexAngles);

    for (PVector rc : reflexCorners) {
      System.out.println("RC: " + rc);
    }

    //PVector reflexCorner = new PVector();
    //if (!reflexCorners.isEmpty()) {
    //  reflexCorner = reflexCorners.get(0);
    //  System.out.println("First Reflex Corner: " + reflexCorner);
    //} else {
    //  System.out.println("No reflex corners found.");
    //}

    //System.out.println("First Reflex Corner: " + reflexCorner);

    for (PVector reflexCorner : reflexCorners) {
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

      if (!newPolygon.isEmpty()) {
        if (isConvexPolygon(newPolygon)) {
          polygons.add(newPolygon);
        } else {
          stack.push(newPolygon); // Add the new polygon for further processing
          System.out.println("\nStack");
          for (ArrayList<Wall> s : stack) {
            System.out.println("\nStack Polygon");
            for (Wall wall : s) {
              System.out.println("Side");
              System.out.println(wall.start);
              System.out.println(wall.end + "\n");
            }
          }
        }
      }

      System.out.println(isConvexPolygon(newPolygon));

      updateCurrent(current, newPolygon, edge);

      if (isConvexPolygon(current)) {
        polygons.add(current);
      } else {
        stack.push(current);
      }

      System.out.println("\nCurrent Map");
      for (Wall wall : current) {
        System.out.println("Side");
        System.out.println(wall.start);
        System.out.println(wall.end + "\n");
      }
    }
    }


    System.out.println("\nList of Convex Polygons");
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

    return polygons;
  }

>>>>>>> Stashed changes
  void updateCurrent(ArrayList<Wall> current, ArrayList<Wall> newPolygon, Wall edge) {
    int currentIndex = -1;
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

    if (currentIndex == 0) {
      current.add(currentIndex, new Wall(edge.end, edge.start));
    } else if (current.get(currentIndex-1).direction.x > 0) {
      if (current.get(currentIndex - 1).end.equals(edge.end)) {
        current.add(currentIndex, new Wall(edge.end, edge.start));
      } else {
        current.add(currentIndex, new Wall(edge.start, edge.end));
      }
    } else {
      current.add(currentIndex, new Wall(edge.end, edge.start));
    }
  }


  ArrayList<Wall> splitPolygon(ArrayList<Wall> polygon, PVector reflexCorner, Wall edge) {
    ArrayList<Wall> newPolygon = new ArrayList<>();
    boolean split = false;

    for (Wall wall : polygon) {
      if (wall.start.equals(edge.start) || wall.start.equals(edge.end)) {
        split = true;
      }

      if (split) {
        newPolygon.add(wall);
        if (wall.end.equals(edge.start)) {
          newPolygon.add(edge);
          break;
        } else if (wall.end.equals(edge.end)) {
          newPolygon.add(new Wall(edge.end, edge.start));
          break;
        }
      }
    }

    return newPolygon;
  }

  // intersects
  Wall createEdge(PVector reflex, ArrayList<Wall> polygon, Map map) {
    //Wall edge = null;
    //float distance = Float.MAX_VALUE;

<<<<<<< Updated upstream
    ////// from the reflex angle
    ////// for each wall in the polygon
    ////// make the candidate as wall.start to connect to reflex angle as an edge
    ////// reflex angle shouldn't be candidate
    ////// reflex-candidate shouldn't be the original wall
    ////// reflex-candidate should be in the polygon
    ////// reflex-candidate shouldn't intersect any of the polygon walls

    ////// check distance from reflex to candidate
    ////// return and create the edge that has the shortest distance

    //Wall edge = null;
    //float distance = Float.MAX_VALUE;

    //for (Wall wall : polygon) {
    //  //Wall wall = polygon.get(0);
    //  PVector candidate = wall.start;
    //  System.out.println("Candidate: " + candidate);

    //  // Check if the edge collides with a wall
    //  if (!reflex.equals(candidate) && !isOriginalWall(reflex, candidate, polygon)) {
    //    // Create a temporary edge for the candidate
    //    Wall tempEdge = new Wall(reflex, candidate);
    //    System.out.println("Temp Edge: " + tempEdge.start + tempEdge.end);

    //    // Check if this edge intersects with any wall in the polygon
    //    boolean intersectsAny = false;
    //    for (Wall existingWall : polygon) {
    //      System.out.println("Intersects: " + intersects(reflex, candidate, existingWall.start, existingWall.end, polygon));
    //      if (intersects(reflex, candidate, existingWall.start, existingWall.end, polygon)) {
    //        intersectsAny = true;
    //        //System.out.println("Intersects: " + existingWall.crosses(tempEdge.start, tempEdge.end));
    //        break;
    //      }
    //    }
    //    //existingWall.crosses(tempEdge.start, tempEdge.end)
    //    // If there are no intersections, check the distance
    //    if (!intersectsAny && distance > PVector.dist(reflex, candidate) &&
    //      isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon)) {

    //      distance = PVector.dist(reflex, candidate);
    //      edge = tempEdge; // Create the edge
    //      System.out.println("New Wall");
    //      System.out.println("Edge: " + edge.start + edge.end);
    //    }
    //  }
    //}

    //if (edge != null) {
    //  System.out.println("Shortest Edge: " + distance);
    //}
=======
    //for (Wall wall : polygon) {
    //  PVector candidate = wall.start;
    //  System.out.println("Candidate: " + candidate);
    //  //System.out.println("Is reflex equals candidate : " + reflex.equals(candidate));
    //  //System.out.println("Is Original Wall: " + isOriginalWall(reflex, candidate, polygon));

    //  if (reflex.equals(candidate)) {
    //    //System.out.println("Reflex equals candidate");
    //    continue;
    //  }

    //  if (isOriginalWall(reflex, candidate, polygon)) {
    //    //System.out.println("Is Original Wall");
    //    continue;
    //  }

    //  edge = new Wall(reflex, candidate);
    //  System.out.println("Edge: " + edge.start + edge.end);
      
    //  System.out.println("Intersects: " + intersects(edge, polygon, map));
      
    //}

>>>>>>> Stashed changes
    //return edge;



<<<<<<< Updated upstream
    //Wall edge = null;
    //float distance = Float.MAX_VALUE;

    ////Wall wall = polygon.get(0);

    //for (Wall wall : polygon) {
    //  PVector candidate = wall.start;
    //  System.out.println("Candidate: " + candidate);
    //  System.out.println(intersects(reflex, candidate, wall.start, wall.end, polygon));
    //  //System.out.println(isPointInPolygon(reflex, polygon));
    //  //System.out.println(reflex.equals(candidate));

    //  // Check if the edge collides with a wall
    //  if (!reflex.equals(candidate) &&
    //    !intersects(reflex, candidate, wall.start, wall.end, polygon) &&
    //    distance > PVector.dist(reflex, candidate) &&
    //    !isOriginalWall(reflex, candidate, polygon) &&
    //    //isPointInPolygon(getRandomPoint(new Wall(reflex, candidate)), polygon)
    //    isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon)
    //    //isPointInPolygon(candidate, polygon)
    //    ) {
    //    System.out.println("New Wall");
    //    distance = PVector.dist(reflex, candidate);
    //    edge = new Wall(reflex, candidate); // Create the edge
    //    System.out.println("Edge: " + edge.start + edge.end);
    //  }
    //  //if (!reflex.equals(candidate) && wall.crosses(candidate, reflex)) {
    //  //  System.out.println("New Wall");
    //  //  return new Wall(reflex, candidate);  // Create the edge
    //  //}
    //}
    //if (edge != null) {
    //  System.out.println("Shortest Edge: " + distance);
    //}
    //return edge;
    
    
    
        Wall edge = null;
=======
    Wall edge = null;
>>>>>>> Stashed changes
    float distance = Float.MAX_VALUE;

    for (Wall wall : polygon) {
      PVector candidate = wall.start;
      System.out.println("Candidate: " + candidate);
<<<<<<< Updated upstream

      //System.out.println(!intersects(reflex, candidate, wall.start, wall.end));

      //System.out.println(intersects(reflex, candidate, wall.start, wall.end, polygon));
      System.out.println(intersects(reflex, candidate, wall.start, wall.end, polygon, map));
      //System.out.println(map.collides(reflex, candidate));
      //System.out.println(isPointInPolygon(reflex, polygon));

      //System.out.println(reflex.equals(candidate));

      // Check if the edge collides with a wall
      if (!reflex.equals(candidate) &&
        !intersects(reflex, candidate, wall.start, wall.end, polygon, map) &&
        //!map.collides(reflex, candidate) && 
=======
      //System.out.println("Is reflex equals candidate : " + reflex.equals(candidate));
      System.out.println("Intersects: " + intersects(reflex, candidate, polygon, map));
      //System.out.println("Is Original Wall: " + isOriginalWall(reflex, candidate, polygon));
      //System.out.println("Is point in Polygon: " + isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon));
      //System.out.println("Distance Shorter: " +  (distance > PVector.dist(reflex, candidate)));
      System.out.println("Map collides: " + map.collides(reflex, candidate));

      // Check if the edge collides with a wall
      if (!reflex.equals(candidate) &&
        !intersects(reflex, candidate, polygon, map) &&
>>>>>>> Stashed changes
        distance > PVector.dist(reflex, candidate) &&
        !isOriginalWall(reflex, candidate, polygon) &&
        //isPointInPolygon(getRandomPoint(new Wall(reflex, candidate)), polygon)
        isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon)
        ) {
        System.out.println("New Wall");
        distance = PVector.dist(reflex, candidate);
        edge = new Wall(reflex, candidate); // Create the edge
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






    //Wall edge = null;
    //float distance = Float.MAX_VALUE;

    //for (Wall wall : polygon) {
    //  PVector candidate = wall.start;
    //  System.out.println("Candidate: " + candidate);
    //  System.out.println(intersects(reflex, candidate, wall.start, wall.end, polygon));
    //  //System.out.println(isPointInPolygon(reflex, polygon));
    //  //System.out.println(reflex.equals(candidate));

    //  // Check if the edge collides with a wall
    //  if (!reflex.equals(candidate) &&
    //    !intersects(reflex, candidate, wall.start, wall.end, polygon) &&
    //    distance > PVector.dist(reflex, candidate) &&
    //    !isOriginalWall(reflex, candidate, polygon) &&
    //    //isPointInPolygon(getRandomPoint(new Wall(reflex, candidate)), polygon)
    //    isPointInPolygon(new PVector(random(reflex.x, candidate.x), random(reflex.y, candidate.y)), polygon)
    //    //isPointInPolygon(candidate, polygon)
    //    ) {
    //    System.out.println("New Wall");
    //    distance = PVector.dist(reflex, candidate);
    //    edge = new Wall(reflex, candidate); // Create the edge
    //    System.out.println("Edge: " + edge.start + edge.end);
    //  }
    //  //if (!reflex.equals(candidate) && wall.crosses(candidate, reflex)) {
    //  //  System.out.println("New Wall");
    //  //  return new Wall(reflex, candidate);  // Create the edge
    //  //}
    //}
    //if (edge != null) {
    //  System.out.println("Shortest Edge: " + distance);
    //}
    //return edge;
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

<<<<<<< Updated upstream
  boolean intersects(PVector p1, PVector p2, PVector p3, PVector p4, ArrayList<Wall> polygon, Map map) {
    for (Wall wall : polygon) {
      System.out.println("Wall: " + wall.start + wall.end);
      System.out.println("Wall crosses: " + wall.crosses(p1, p2));
      System.out.println("Start equal: " + wall.start.equals(p2));

      if (map.collides(p1, p2)) {
        if (wall.start.equals(p2) || wall.end.equals(p2)) {
          return false;
        } else {
          return true;
        }
      }
    }

    return false;
    //PVector d1 = PVector.sub(p2, p1).normalize();
    //PVector d2 = PVector.sub(p4, p3).normalize();

=======
  //boolean intersects(PVector p1, PVector p2, PVector p3, PVector p4, ArrayList<Wall> polygon, Map map) {
  boolean intersects(PVector reflex, PVector candidate, ArrayList<Wall> polygon, Map map) {
    
    //crosses
    for(Wall wall : polygon){
      System.out.println("Crosses: " + wall.crosses(reflex, candidate));
      if(wall.crosses(reflex, candidate)){
        System.out.println("Wall.start equals candidate: " + wall.start + wall.start.equals(candidate));
        System.out.println("Wall.end equals candidate: " + wall.end + wall.end.equals(candidate));
        if(wall.start.equals(candidate) || wall.end.equals(candidate)) {
          return false;
        }
        return true;
      }
    }
    
    return false;
    

    //PVector d1 = PVector.sub(p2, p1).normalize();
    //PVector d2 = PVector.sub(p4, p3).normalize();

>>>>>>> Stashed changes
    //float dist1 = d1.dot(PVector.sub(p3, p1).normalize());
    //float dist2 = d1.dot(PVector.sub(p4, p1).normalize());
    //float dist3 = d2.dot(PVector.sub(p1, p3).normalize());
    //float dist4 = d2.dot(PVector.sub(p2, p3).normalize());

    //return (dist1 * dist2 < 0 && dist3 * dist4 < 0);
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

  ArrayList<PVector> findReflexAngles(ArrayList<Wall> corners, ArrayList<PVector> reflexAngles) {
    // Determine which corners are non-convex (concave) by checking if the angle is > 180
    // a.normal.dot(b.direction)

    reflex = new ArrayList<>();

    ArrayList<PVector> reflex = new ArrayList<>();

    for (int i = 0; i < corners.size(); i++) {
      Wall current = corners.get(i);
      Wall next = corners.get((i + 1) % corners.size());
      Wall previous = corners.get((i - 1 + corners.size()) % corners.size());

      //System.out.println("Current Wall: " + current.start + current.end);
      //System.out.println("Next Wall: " + next.start + next.end);
      //System.out.println("Previous Wall: " + previous.start + previous.end);

      if (isReflex(current, next, previous)) {
        reflex.add(current.start);
        //System.out.println("Reflex Angle Found");
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

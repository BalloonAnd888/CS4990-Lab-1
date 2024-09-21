Flock flock;

class Flock {
  ArrayList<Boid> boids;

  Flock() {
    boids = new ArrayList<Boid>();
  }

  // Separation - steer to avoid crowding local flockmates
  PVector separate() {
    PVector steer = new PVector(0, 0);
    
    
    
    return steer;
  }

  // Alignment


  // Cohesion
}

/// called when "f" is pressed; should instantiate additional boids and start flocking
void flock(Boid billy)
{
  flock = new Flock();

  flock.boids.add(billy);

  for (int i = 0; i < 8; i++) {
    PVector position = new PVector(random(width), random(height));
    flock.boids.add(new Boid(position, BILLY_START_HEADING, BILLY_MAX_SPEED, BILLY_MAX_ROTATIONAL_SPEED, BILLY_MAX_ACCELERATION, BILLY_MAX_ROTATIONAL_ACCELERATION));
    System.out.println(position);
}
  System.out.println(flock.boids);

  // PVector sep = separate
  // PVector ali = align
  // PVector coh = cohesion

  // sep.mult(1.5)
  // ali.mult(1.0)
  // coh.mult(1.0)
}

/// called when "f" is pressed again; should remove the flock
void unflock(Boid billy)
{
  flock = new Flock();
  flock.boids.add(billy);
  System.out.println(flock.boids);
}



//// Separation
// // Method checks for nearby boids and steers away
// PVector separate (ArrayList<Boid> boids) {
//   float desiredseparation = 25.0f;
//   PVector steer = new PVector(0, 0, 0);
//   int count = 0;
//   // For every boid in the system, check if it's too close
//   for (Boid other : boids) {
//     float d = PVector.dist(position, other.position);
//     // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
//     if ((d > 0) && (d < desiredseparation)) {
//       // Calculate vector pointing away from neighbor
//       PVector diff = PVector.sub(position, other.position);
//       diff.normalize();
//       diff.div(d);        // Weight by distance
//       steer.add(diff);
//       count++;            // Keep track of how many
//     }
//   }
//   // Average -- divide by how many
//   if (count > 0) {
//     steer.div((float)count);
//   }

//   // As long as the vector is greater than 0
//   if (steer.mag() > 0) {
//     // First two lines of code below could be condensed with new PVector setMag() method
//     // Not using this method until Processing.js catches up
//     // steer.setMag(maxspeed);

//     // Implement Reynolds: Steering = Desired - Velocity
//     steer.normalize();
//     steer.mult(maxspeed);
//     steer.sub(velocity);
//     steer.limit(maxforce);
//   }
//   return steer;
// }

// // Alignment
//// For every nearby boid in the system, calculate the average velocity
//PVector align (ArrayList<Boid> boids) {
//  float neighbordist = 50;
//  PVector sum = new PVector(0, 0);
//  int count = 0;
//  for (Boid other : boids) {
//    float d = PVector.dist(position, other.position);
//    if ((d > 0) && (d < neighbordist)) {
//      sum.add(other.velocity);
//      count++;
//    }
//  }
//  if (count > 0) {
//    sum.div((float)count);
//    // First two lines of code below could be condensed with new PVector setMag() method
//    // Not using this method until Processing.js catches up
//    // sum.setMag(maxspeed);

//    // Implement Reynolds: Steering = Desired - Velocity
//    sum.normalize();
//    sum.mult(maxspeed);
//    PVector steer = PVector.sub(sum, velocity);
//    steer.limit(maxforce);
//    return steer;
//  }
//  else {
//    return new PVector(0, 0);
//  }
//}

//// Cohesion
//// For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
//PVector cohesion (ArrayList<Boid> boids) {
//  float neighbordist = 50;
//  PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
//  int count = 0;
//  for (Boid other : boids) {
//    float d = PVector.dist(position, other.position);
//    if ((d > 0) && (d < neighbordist)) {
//      sum.add(other.position); // Add position
//      count++;
//    }
//  }
//  if (count > 0) {
//    sum.div(count);
//    return seek(sum);  // Steer towards the position
//  }
//  else {
//    return new PVector(0, 0);
//  }
//}

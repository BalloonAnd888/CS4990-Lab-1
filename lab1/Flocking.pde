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

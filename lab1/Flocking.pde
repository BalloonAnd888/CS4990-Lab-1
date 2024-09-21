Flock flock;

class Flock {
  ArrayList<Boid> boids;

  Flock() {
    boids = new ArrayList<Boid>();
  }

  void update(float dt) {
    for (Boid boid : boids) {
      boid.update(dt);
    }
  }

  // Separation - steer to avoid crowding local flockmates
  PVector separate(Boid boid) {
    PVector steer = new PVector(0, 0);



    return steer;
  }

  // Alignment - steer towards the average heading of local flockmates




  // Cohesion - steer to move toward the average position of local flockmates
  
  
  
}

/// called when "f" is pressed; should instantiate additional boids and start flocking
void flock(Boid billy)
{
  flock = new Flock();

  flock.boids.add(billy);

  for (int i = 0; i < 8; i++) {
    PVector position = new PVector(random(BILLY_START.x - 100, BILLY_START.x+100), random(BILLY_START.y - 100, BILLY_START.y+100));
    flock.boids.add(new Boid(position, BILLY_START_HEADING, BILLY_MAX_SPEED, BILLY_MAX_ROTATIONAL_SPEED, BILLY_MAX_ACCELERATION, BILLY_MAX_ROTATIONAL_ACCELERATION));
    System.out.println(position);
  }
  System.out.println(flock.boids);
}

/// called when "f" is pressed again; should remove the flock
void unflock(Boid billy)
{
  flock = new Flock();
  flock.boids.add(billy);
  System.out.println(flock.boids);
}

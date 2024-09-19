/// In this file, you will have to implement seek and waypoint-following
/// The relevant locations are marked with "TODO"

class Crumb
{
  PVector position;
  Crumb(PVector position)
  {
    this.position = position;
  }
  void draw()
  {
    fill(255);
    noStroke();
    circle(this.position.x, this.position.y, CRUMB_SIZE);
  }
}

class Boid
{
  Crumb[] crumbs = {};
  int last_crumb;
  float acceleration;
  float rotational_acceleration;
  KinematicMovement kinematic;
  PVector target;

  Boid(PVector position, float heading, float max_speed, float max_rotational_speed, float acceleration, float rotational_acceleration)
  {
    this.kinematic = new KinematicMovement(position, heading, max_speed, max_rotational_speed);
    this.last_crumb = millis();
    this.acceleration = acceleration;
    this.rotational_acceleration = rotational_acceleration;
  }

  void update(float dt)
  {
    if (target != null)
    {
      // TODO: Implement seek here

      //
      // get distance from boid to target
      // rotate boid towards the target
      // set arrival radius of target
      // if boid is in arrival radius, decrease speed and rotational velocity
      // else increaseSpeed(max_speed, max_rotational_acceleration)
      // increaseSpeed(float ds, float drs) ds - linear velocity, drs - rotational velocity
      //

      System.out.println("Target: " + target);
      PVector distance = PVector.sub(target, this.kinematic.position);
      System.out.println(distance);

      float angle = atan2(distance.y, distance.x);
      //print(angle + "\n");

      float angleDiff = normalize_angle_left_right(angle - this.kinematic.getHeading());
      //print(angleDiff + "\n");

      //float velocity = this.kinematic.getSpeed();
      float velocity = 5;
      System.out.println(velocity);
      
      float arrivalRadius = 10;
      
      if(distance.x > arrivalRadius + target.x || abs(distance.y) > abs(arrivalRadius + target.y)) {
        System.out.println("Hi");
        //increaseSpeed(); decrease speed and rotational velocity
      }
      
      this.kinematic.increaseSpeed(velocity, angleDiff);



      //this.kinematic.increaseSpeed(0,0);
      //this.seek(target);

      //this.kinematic.getSpeed();
      //this.kinematic.getRotationalVelocity();



    }

    // place crumbs, do not change
    if (LEAVE_CRUMBS && (millis() - this.last_crumb > CRUMB_INTERVAL))
    {
      this.last_crumb = millis();
      this.crumbs = (Crumb[])append(this.crumbs, new Crumb(this.kinematic.position));
      if (this.crumbs.length > MAX_CRUMBS)
        this.crumbs = (Crumb[])subset(this.crumbs, 1);
    }

    // do not change
    this.kinematic.update(dt);

    draw();
  }

  void draw()
  {
    for (Crumb c : this.crumbs)
    {
      c.draw();
    }

    fill(255);
    noStroke();
    float x = kinematic.position.x;
    float y = kinematic.position.y;
    float r = kinematic.heading;
    circle(x, y, BOID_SIZE);
    // front
    float xp = x + BOID_SIZE*cos(r);
    float yp = y + BOID_SIZE*sin(r);

    // left
    float x1p = x - (BOID_SIZE/2)*sin(r);
    float y1p = y + (BOID_SIZE/2)*cos(r);

    // right
    float x2p = x + (BOID_SIZE/2)*sin(r);
    float y2p = y - (BOID_SIZE/2)*cos(r);
    triangle(xp, yp, x1p, y1p, x2p, y2p);
  }

  void seek(PVector target)
  {
    this.target = target;
  }

  void follow(ArrayList<PVector> waypoints)
  {
    // TODO: change to follow *all* waypoints
    this.target = waypoints.get(0);

    System.out.println(waypoints);
    //for(int i = 0; i < waypoints.size(); i++) {
    //  System.out.println(waypoints.get(i));
    //  this.target = waypoints.get(i);

    //}

    System.out.println(this.kinematic.getHeading());
  }
}

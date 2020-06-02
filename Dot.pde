class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean reachedGoal = false;
  boolean dead = false;
  boolean isBest = false;

  float fitness = 0;

  Dot() {
    brain = new Brain(400);

    pos = new PVector(width/2, height-30);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  //-----------------------------------------------------------------------------------------

  void show() {
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //-----------------------------------------------------------------------------------------

  void move() {
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }

    vel.add(acc);
    vel.limit(6);
    pos.add(vel);
  }

  //------------------------------------------------------------------------------------------

  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2) {
        dead = true;
        /*rect(0, 200, 500, 10);
        rect(300, 500, 500, 10);
        rect(100, 400, 200, 10);*/
      } else if ((pos.x>=0&&pos.x<=500&&pos.y>=200&&pos.y<=210)||(pos.x>=300&&pos.x<=800&&pos.y>=500&&pos.y<=510)||(pos.x>=100&&pos.x<=300&&pos.y>=400&&pos.y<=410)){
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y)<5) {
        reachedGoal = true;
      }
    }
  }

  //------------------------------------------------------------------------------------------

  void calculateFitness() {
    if (reachedGoal) {
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step*brain.step);
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal*distanceToGoal);
    }
  }

  //------------------------------------------------------------------------------------------
  //clone it
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}

Population test;

PVector goal = new PVector(400, 10);

void setup()
{
  size(800, 800);
  setResizable(true);

  test = new Population(1000);
}

void draw()
{
  background(255);

  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  rect(0, 200, 500, 10);
  rect(300, 500, 500, 10);
  rect(100, 400, 200, 10);

  if (test.allDotsDead()) {
    //genetic algoritm
    test.calculateFitness();
    test.naturalSelection();
    ;
    test.mutateDemBabies();
  } else {
    test.update();
    test.show();
  }
}

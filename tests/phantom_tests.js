casper.test.begin('Home page', 1, function suite(test) {
  casper.start("./dist/index.html", function() {
    test.assertTitle("Craughwell Furniture", "Craughwell Furniture title is the one expected");
  });

  casper.run(function() {
    test.done();
  });
});

class CollisionDetector{
  CollisionDetector(){}
  
  void update(List<Entity> entities){
    generateTree(entities);
    updateEntities(entities);
  }
  
  private void updateEntities(List<Entity> entities){
    for(Entity from: entities){
      for(Entity to: _tree.detectedEntities(from)){
        from.callCollidingEvent(to.type());
      }
    }
  }
  
  // private Entity[2][] _detectedPair;
  private List<Entity[]> _detectedPairs;
  
  private void generateTree(List<Entity> entities){
    _tree = new AABBNode(entities);
  };
  
  // private void generateTreeRec(){}
  
  private AABBNode _tree;
  
}

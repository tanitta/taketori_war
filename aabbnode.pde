import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.util.Collections;

class AABBNode{
  AABBNode(List<Entity> entities){
    _isLeaf = entities.size() == 1;
    
    if(!isLeaf()){
      sort(entities, sortingAxis(entities));
      generateNexts(entities);
    }else{
      _entity = entities.get(0);
      _min = new PVector(_entity.x()-_entity.width()/2, _entity.y()-_entity.height()/2);
      _max = new PVector(_entity.x()+_entity.width()/2, _entity.y()+_entity.height()/2);
    }
  }
  
  boolean isLeaf(){
    return _isLeaf;
  }
  
  List<Entity> detectedEntities(Entity entity){
    List<Entity> l = new ArrayList<Entity>();
    
    boolean isColliding = 
    entity.x() + entity.width()/2 > _min.x &&
    entity.x() - entity.width()/2 < _max.x &&
    entity.y() + entity.height()/2 > _min.y &&
    entity.y() - entity.height()/2 < _max.y;
    
    if(isColliding){
      if(_isLeaf){
        if(_entity != entity){
          l.add(_entity);
        }
      }else{
        l.addAll(_next.get(0).detectedEntities(entity));
        l.addAll(_next.get(1).detectedEntities(entity));
      }
    }
    return l;
  }
  
  private List<AABBNode> _next;
  private Entity _entity;
  private boolean _isLeaf;
  private PVector _max;
  private PVector _min;
  
  private void generateNexts(List<Entity> entities){
    int size = entities.size();
    _next = new ArrayList<AABBNode>();
    _next.add(new AABBNode(entities.subList(0, size/2)));
    _next.add(new AABBNode(entities.subList(size/2, size)));
  }
  
  private void sort(List<Entity> entities, int axis){
    EntityComparator comparator = new EntityComparator(axis);
    
    Collections.sort(entities, comparator); 
  }
  
  private int sortingAxis(List<Entity> entities){
    PVector min = new PVector(0, 0);
    PVector max = new PVector(0, 0);
    for(Entity entity : entities){
      min.x = min(min.x, entity.x() - entity.width()/2);
      max.x = max(max.x, entity.x() + entity.width()/2);
      
      min.y = min(min.y, entity.y() - entity.height()/2);
      max.y = max(max.y, entity.y() + entity.height()/2);
    }
    
    _min = min;
    _max = max;
    PVector d = max.sub(min);
    return (d.x > d.y)? 0:1;
  }
}

import java.util.Comparator;

public class EntityComparator implements Comparator<Entity> {
    EntityComparator(int axis){_sortingAxis = axis;}
    //比較メソッド（データクラスを比較して-1, 0, 1を返すように記述する）
    public int compare(Entity a, Entity b) {
      if(_sortingAxis == 0){
        boolean bool = a.x() < b.x();
        return bool?1:0;
      }else{
        boolean bool = a.y() < b.y();
        return bool?1:0;
      }
    }
    
    private int _sortingAxis;
}

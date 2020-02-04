


class ToArrayList{
  
  ArrayList newList = new ArrayList();
  
  private int dimensions = 0;
  private ArrayList<Integer> getters = new ArrayList(); // holds the .get() for each dimension
  
  
  ToArrayList(String list){
    
    getters.add(0);
    
    for (int i = 1; i < list.length()-1; i++){ // start i at 1 because ArrayList.toString() starts with [
      
      if (list.charAt(i) == '['){
        addList();
        dimensions ++;
      }
      else if (list.charAt(i) == ']'){
        dimensions --;
        getters.set(dimensions, ((int)getters.get(dimensions)) + 1);
      }
      else if (list.charAt(i) != ' ' && list.charAt(i)!= ','){
        addToList(list.charAt(i));
      }
      else{
        
      }
     
    } // end of for loop
  
    
    returner();
  
  
  } // end of toArrayList
  
  void addList(){
    
    if(getters.size()-1 < dimensions + 1){
      getters.add(0);
    }
    
    if(dimensions == 0){
      newList.add(new ArrayList());
      getters.set(1, 0);
    }
    if(dimensions == 1){
      ((ArrayList)newList.get((int)getters.get(0))).add(new ArrayList());
      getters.set(2, 0);
    }
    if(dimensions == 2){
      ((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).add(new ArrayList());
      getters.set(3, 0);
    }
    if(dimensions == 3){
      ((ArrayList)((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).get((int)getters.get(2))).add(new ArrayList());
      getters.set(4, 0);
    }
    if(dimensions == 4){
      ((ArrayList)((ArrayList)((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).get((int)getters.get(2))).get((int)getters.get(3))).add(new ArrayList());
      getters.set(5, 0);
    }
    
  }
  
  void addToList(char i){
    
    
    if(dimensions == 0){
      newList.add((float)Float.parseFloat(i+""));
      getters.set(0, ((int)getters.get(0)) + 1);
    }
    if(dimensions == 1){
      
      ((ArrayList)newList.get((int)getters.get(0))).add((float)Float.parseFloat(i+""));
      getters.set(1, ((int)getters.get(1)) + 1);
    }
    if(dimensions == 2){
      ((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).add((float)Float.parseFloat(i+""));
      getters.set(2, ((int)getters.get(2)) + 1);
    }
    if(dimensions == 3){
      ((ArrayList)((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).get((int)getters.get(2))).add((float)Float.parseFloat(i+""));
      getters.set(3, ((int)getters.get(3)) + 1);
    }
    if(dimensions == 4){
      ((ArrayList)((ArrayList)((ArrayList)((ArrayList)newList.get((int)getters.get(0))).get((int)getters.get(1))).get((int)getters.get(2))).get((int)getters.get(3))).add((float)Float.parseFloat(i+""));
      getters.set(4, ((int)getters.get(4)) + 1);
    }
    
  }
  
  ArrayList returner(){
    
    return newList;
    
  }
  
  
  
  
}
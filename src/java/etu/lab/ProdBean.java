package etu.lab;

import java.io.Serializable;

public class ProdBean implements Serializable {

    private String price;
    private String tag;
    private String link;
    
    public ProdBean(){
       setPrice("0");
       setTag("0");
       setLink("0");
    }
    
    public void setPrice(String newName) {
        this.price = newName;
    }

    public String getPrice() {
        return this.price;
    }
     
    public void setTag(String newID) {
        this.tag = newID;
    }

    public String getTag() {
        return this.tag;
    }
    
      public void setLink(String newStory) {
        this.link= newStory;
    }

    public String getLink() {
        return this.link;
    }
    

}

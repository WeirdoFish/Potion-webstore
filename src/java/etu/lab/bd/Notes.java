package etu.lab.bd;

import java.util.ArrayList;
import java.util.Date;

public class Notes {

        Integer price;
        String magazine;
        Date date;
        ArrayList<Integer> ids; 
        ArrayList<Integer> ams; 
        
        public ArrayList<Integer> getIds(){
            return ids;
        }
        public ArrayList<Integer> getAms(){
            return ams;
        }

        public Notes(Integer pr, String mg, Date dt, ArrayList<Integer> id, ArrayList<Integer> am) {
            price = pr;
            magazine = mg;
            date = dt;
            ids=id;
            ams=am;
        }

        public void setPrice(Integer pr) {
            this.price = pr;
        }

        public Integer getPrice() {
            return price;
        }

        public void setMagazine(String mg) {
            this.magazine = mg;
        }

        public String getMagazine() {
            return magazine;
        }

        public void setDate(Date dt) {
            this.date = dt;
        }

        public Date getDate() {
            return date;
        }
    }
   

package etu.lab;

import java.util.ArrayList;
import java.util.Objects;

public class CartBean {

    public class Order {

        private Integer id;
        private Integer price;
        private Integer count;

        public Order(Integer new_id, Integer pr) {
            id = new_id;
            price = pr;
            count = 1;
        }

        public Integer getID() {
            return id;
        }

        public Integer getPrice() {
            return price;
        }

        public Integer getCount() {
            return count;
        }

        public void incCount() {
            count++;
        }

        public void decCount() {
            count--;
        }
    }

    private ArrayList<Order> data = new ArrayList<>();

    public void add(Integer id, Integer pr) {
        Integer idx = isExist(id);
        if (idx == -1) {
            data.add(new Order(id, pr));
        } else {
            data.get(idx).incCount();
        }
    }

    public void del(Integer id) {
        Integer idx = findIdxByID(id);
        if (idx != -1) {
            if (getProdCount(idx) > 1) {
                data.get(idx).decCount();
            } else {
                data.remove(data.get(idx));
            }
        }
    }

    public void clearCart() {
        data = new ArrayList<>();
    }

    public ArrayList<Order> getList() {
        return data;
    }

    public Integer isExist(Integer id) {
        Integer res = -1;
        for (int i = 0; i < data.size(); i++) {
            if (data.get(i).getID().equals(id)) {
                res = i;
                break;
            }
        }
        return res;
    }

    public Integer calc(Integer idx) {
        return getProdPrice(idx) * getProdCount(idx);
    }

    public Integer calcAll() {
        Integer all = 0;

        for (int i = 0; i < data.size(); i++) {
            all = all + data.get(i).getPrice() * data.get(i).getCount();
        }

        return all;
    }

    public Integer getProdPrice(Integer idx) {
        return data.get(idx).getPrice();
    }

    public Integer getProdID(Integer idx) {
        return data.get(idx).getID();
    }

    public Integer getSize() {
        return data.size();
    }

    public Integer getProdCount(Integer idx) {
        return data.get(idx).getCount();
    }

    public String getProductPath(Integer idx) {
        return "cartItem.jsp?id=" + data.get(idx).getID().toString();
    }

    public Integer findIdxByID(Integer id) {
        Integer ret = -1;
        for (int i = 0; i < data.size(); i++) {
            if (data.get(i).getID().equals(id)) {
                ret = i;
                break;
            }
        }
        return ret;
    }
}

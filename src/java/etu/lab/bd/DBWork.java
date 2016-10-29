package etu.lab.bd;

import etu.lab.CartBean;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class DBWork {


    public DBWork() {
        
    }

    static public void addOrder(String user, String magazine, CartBean order) {
        Session session = MyHibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        Integer resId = null;
        Integer itId = null;
        try {
            tx = session.beginTransaction();
            History h = new History(user, new Date(), magazine, order.calcAll());
            session.save(h);

            ArrayList<CartBean.Order> things = order.getList();

            for (CartBean.Order thing : things) {
                Items item = new Items(thing.getID(), thing.getCount(), h);
                session.save(item);
            }

            tx.commit();
            order.clearCart();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

    }

  
    static public ArrayList<Notes> getHist(String username) {
        Session session = null;
        Transaction tx = null;
        ArrayList<Notes> notes = new ArrayList();

        try {
            session = MyHibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            List list = session.createQuery("FROM History WHERE CUSTOMER='"+username+"'").list();
            
            for (Iterator iterator = list.iterator(); iterator.hasNext();) {
                History cur = (History) iterator.next();
                Integer order_num = cur.getPurchase();
                
                ArrayList<Integer> item_ids = new ArrayList();
                ArrayList<Integer> item_ams = new ArrayList();
                List ItemsList = session.createQuery("FROM Items WHERE PURCHASE='"+order_num+"'").list();
                
                for (Iterator iter = ItemsList.iterator(); iter.hasNext();) {
                    Items curIt = (Items)iter.next();
                    item_ids.add(curIt.getItem());
                    item_ams.add(curIt.getAmount());
                }
                notes.add(new Notes(cur.getPrice(),cur.getShip(),cur.getTime(),item_ids,item_ams));
            } 
            tx.commit();
            return notes;
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

}

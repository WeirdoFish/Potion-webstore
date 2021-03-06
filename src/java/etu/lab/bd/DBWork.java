package etu.lab.bd;

import etu.lab.CartBean;
import java.sql.Timestamp;
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
            /*  if (lang.getLanguage().equals(new Locale("en").getLanguage())) {
                datetime.setHours(datetime.getHours() + 3);
            } else if (lang.getLanguage().equals(new Locale("lat").getLanguage())) {
                datetime.setHours(datetime.getHours() + 2);
            }
             */
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
            List list = session.createQuery("FROM History WHERE CUSTOMER='" + username + "' ORDER BY PURCHASE DESC").list();

            for (Iterator iterator = list.iterator(); iterator.hasNext();) {
                History cur = (History) iterator.next();
                Integer order_num = cur.getPurchase();

                ArrayList<Integer> item_ids = new ArrayList();
                ArrayList<Integer> item_ams = new ArrayList();
                List ItemsList = session.createQuery("FROM Items WHERE PURCHASE='" + order_num + "'").list();

                for (Iterator iter = ItemsList.iterator(); iter.hasNext();) {
                    Items curIt = (Items) iter.next();
                    item_ids.add(curIt.getItem());
                    item_ams.add(curIt.getAmount());
                }
                notes.add(new Notes(cur.getPrice(), cur.getShip(), cur.getTime(), item_ids, item_ams));
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

    static public ArrayList<Comments> getComments() {
        Session session = MyHibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            List list = session.createQuery("FROM Comments ORDER BY DATETIME").list();
            ArrayList<Comments> coms = new ArrayList();

            for (Iterator iterator = list.iterator(); iterator.hasNext();) {
                Comments cur = (Comments) iterator.next();
                coms.add(cur);
            }

            tx.commit();
            return coms;
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

    static public void addComment(String user, String text, Timestamp date) {
        Session session = MyHibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Comments com = new Comments(user, text, date);
            session.save(com);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }

    }
}

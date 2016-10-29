package etu.lab.bd;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlTransient;

@Entity
public class History implements Serializable {

    @Column(name = "CUSTOMER")
    private String customer;
    @Column(name = "PRICE")
    private Integer price;
    @Id
    @Basic(optional = false)
    @Column(name = "PURCHASE")
    private Integer purchase;
    @Column(name = "TIME")
    @Temporal(TemporalType.DATE)
    private Date time;
    @Column(name = "SHIP")
    private String ship;
    @OneToMany(mappedBy = "purchase")
    private Collection<Items> itemsCollection;

    private static final long serialVersionUID = 1L;


    public History() {
    }

   
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (purchase!= null ? purchase.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof History)) {
            return false;
        }
        History other = (History) object;
        if ((this.purchase == null && other.purchase != null) || (this.purchase!= null && !this.purchase.equals(other.purchase))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "etu.lab.bd.History[ purchase=" + purchase + " ]";
    }

    public Integer toInteger() {
        return purchase;
    }

    public History(String customer, Date time, String ship, Integer price) {
        setCustomer(customer);
        //setPurchase(purchase);
        setTime(time);
        setShip(ship);
        setPrice(price);
    }

    public History(Integer purchase) {
        this.purchase = purchase;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }
     public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getPurchase() {
        return purchase;
    }

    public void setPurchase(Integer purchase) {
        this.purchase = purchase;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getShip() {
        return ship;
    }

    public void setShip(String ship) {
        this.ship = ship;
    }

    @XmlTransient
    public Collection<Items> getItemsCollection() {
        return itemsCollection;
    }

    public void setItemsCollection(Collection<Items> itemsCollection) {
        this.itemsCollection = itemsCollection;
    }

   
}

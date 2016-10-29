package etu.lab.bd;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "ITEMS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Items.findAll", query = "SELECT i FROM Items i"),
    @NamedQuery(name = "Items.findByItem", query = "SELECT i FROM Items i WHERE i.item = :item"),
    @NamedQuery(name = "Items.findByNum", query = "SELECT i FROM Items i WHERE i.num = :num"),
    @NamedQuery(name = "Items.findByAmount", query = "SELECT i FROM Items i WHERE i.amount = :amount")})
public class Items implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "ITEM")
    private Integer item;
    @Id
    @Basic(optional = false)
    @Column(name = "NUM")
    private Integer num;
    @Column(name = "AMOUNT")
    private Integer amount;
    
    @ManyToOne
    @JoinColumn(name = "PURCHASE", referencedColumnName = "PURCHASE")
    private History purchase;

    public Items(Integer Item, Integer amount, History purchase) {
        setItem(Item);
        setAmount(amount);
        setPurchase(purchase);
    }

    public Items() {
        
    }

    public Integer getItem() {
        return item;
    }

    public void setItem(Integer item) {
        this.item = item;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public History getPurchase() {
        return purchase;
    }

    public void setPurchase(History purchase) {
        this.purchase = purchase;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (num != null ? num.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Items)) {
            return false;
        }
        Items other = (Items) object;
        if ((this.num == null && other.num != null) || (this.num != null && !this.num.equals(other.num))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "etu.lab.bd.Items[ num=" + num + " ]";
    }

}

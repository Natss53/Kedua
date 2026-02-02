from flask import Flask, render_template, request, redirect, url_for
import mysql.connector

app = Flask(__name__)

# Pastikan nama database sesuai dengan yang ada di MySQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",  # Gantilah dengan password yang sesuai jika diperlukan
    database="db_niko"  # Pastikan nama database benar
)

@app.template_filter('rupiah')
def rupiah(value):
    try:
        return f"Rp {int(value):,}".replace(",", ".")
    except:
        return "Rp 0"

@app.route("/", methods=["GET", "POST"])
def transaksi_niko():
    cursor = db.cursor(dictionary=True)

    if request.method == "POST":
        nama_baru = request.form.get("nama_pasien_baru")

        if nama_baru:
            cursor.execute("""
                INSERT INTO pasien_niko (nama_niko, alamat_niko, kontak_niko)
                VALUES (%s, %s, %s)
            """, (
                nama_baru,
                request.form.get("alamat_niko"),
                request.form.get("kontak_niko")
            ))
            db.commit()
            id_pasien = cursor.lastrowid
        else:
            id_pasien = request.form["id_pasien_niko"]

        cursor.execute("""
            INSERT INTO transaksi_niko
            (id_pasien_niko, id_kamar_niko, total_biaya_niko,
             status_pembayaran_niko, tgl_niko, tgl_keluar_niko)
            VALUES (%s, %s, %s, %s, CURDATE(), %s)
        """, (
            id_pasien,
            request.form["id_kamar_niko"],
            request.form["total_biaya_niko"],
            request.form["status_pembayaran_niko"],
            request.form["tgl_keluar_niko"]
        ))
        db.commit()
        return redirect(url_for("transaksi_niko"))

    cursor.execute("""
        SELECT t.*, p.nama_niko, k.no_kamar_niko
        FROM transaksi_niko t
        JOIN pasien_niko p ON t.id_pasien_niko = p.id_pasien_niko
        JOIN kamar_niko k ON t.id_kamar_niko = k.id_kamar_niko
        ORDER BY t.id_transaksi_niko DESC
    """)
    data_niko = cursor.fetchall()

    cursor.execute("SELECT * FROM pasien_niko")
    pasien_niko = cursor.fetchall()

    cursor.execute("SELECT * FROM kamar_niko WHERE status_kamar_niko='tersedia'")
    kamar_niko = cursor.fetchall()

    return render_template(
        "transaksi.html",
        data_niko=data_niko,
        pasien_niko=pasien_niko,
        kamar_niko=kamar_niko
    )

@app.route("/pasien")
def pasien():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM pasien_niko")
    data_pasien = cursor.fetchall()
    return render_template("pasien.html", pasien_niko=data_pasien)

@app.route("/edit/<int:id_transaksi>")
def edit_niko(id_transaksi):
    cursor = db.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM transaksi_niko WHERE id_transaksi_niko=%s",
        (id_transaksi,)
    )
    transaksi = cursor.fetchone()

    cursor.execute("SELECT * FROM pasien_niko")
    pasien_niko = cursor.fetchall()

    cursor.execute("SELECT * FROM kamar_niko")
    kamar_niko = cursor.fetchall()

    return render_template(
        "edit_transaksi.html",
        transaksi=transaksi,
        pasien_niko=pasien_niko,
        kamar_niko=kamar_niko
    )

@app.route("/update/<int:id_transaksi>", methods=["POST"])
def update_niko(id_transaksi):
    cursor = db.cursor()

    cursor.execute("""
        UPDATE transaksi_niko SET
        id_pasien_niko=%s,
        id_kamar_niko=%s,
        total_biaya_niko=%s,
        status_pembayaran_niko=%s,
        tgl_keluar_niko=%s
        WHERE id_transaksi_niko=%s
    """, (
        request.form["id_pasien_niko"],
        request.form["id_kamar_niko"],
        request.form["total_biaya_niko"],
        request.form["status_pembayaran_niko"],
        request.form["tgl_keluar_niko"],
        id_transaksi
    ))
    db.commit()
    return redirect(url_for("transaksi_niko"))

@app.route("/delete/<int:id_transaksi>")
def delete_niko(id_transaksi):
    cursor = db.cursor()
    cursor.execute(
        "DELETE FROM transaksi_niko WHERE id_transaksi_niko=%s",
        (id_transaksi,)
    )
    db.commit()
    return redirect(url_for("transaksi_niko"))



if __name__ == "__main__":
    app.run(debug=True)
